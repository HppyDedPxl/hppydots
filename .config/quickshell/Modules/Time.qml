import "../Appearance"
import "../Services"
import "./"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io // for Process
import Quickshell.Widgets

BaseModule {
    id: baseModule

    property var textShort: ""
    property var textLong: ""

    content: _content
    popupContent: popup
    popupOverrideWidth: 250
    dbgName: "TimeModule"

    Component {
        id: _content

        Rectangle {
            id: wrapper

            anchors.fill: parent
            color: 'transparent'

            StyledText {
                // give the text an ID we can refer to elsewhere in the file
                id: clockText
                color: baseModule.textColorOnBar
                padding: 20
                anchors.centerIn: wrapper
                text: baseModule.textShort
                clip: true

                // create a process management object
                Process {
                    // Listen for the streamFinished signal, which is sent
                    // when the process closes stdout or exits.
                    id: longClockProc
                    // the command it will run, every argument is its own string
                    command: ["date", "+%H:%M %b %d (%a)"]
                    // run the command immediately
                    running: true
                    // process the stdout stream using a StdioCollector
                    // Use StdioCollector to retrieve the text the process sends
                    // to stdout.
                    stdout: StdioCollector {
                        onStreamFinished: baseModule.textLong = this.text // `this` can be omitted
                    }
                }

                Process {
                    // `this` can be omitted
                    id: shortClockProc
                    // the command it will run, every argument is its own string
                    command: ["date", "+%H:%M"]
                    // run the command immediately
                    running: true
                    // process the stdout stream using a StdioCollector
                    // Use StdioCollector to retrieve the text the process sends
                    // to stdout.
                    stdout: StdioCollector {
                        // Listen for the streamFinished signal, which is sent
                        // when the process closes stdout or exits.
                        onStreamFinished: baseModule.textShort = this.text
                    }
                }

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: {
                        shortClockProc.running = true;
                        longClockProc.running = true;
                    }
                }

            }

        }

    }

    // What will be in the popup
    Component {
        id: popup

        Column {
            id: popupColumn

            height: 50
            width: baseModule.width

            Rectangle {
                width: parent.width
                height: 50
                color: 'transparent'

                StyledText {
                    anchors.centerIn: parent
                    text: baseModule.textLong
                }

            }

        }

    }

}
