import "../Appearance"
import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell

Component {
    id: dayComponent

    Rectangle {
        id: dayRoot

        required property string model
        required property int index
        required property var date

        color: "transparent"
        Layout.fillWidth: true
        Layout.fillHeight: true


        property var mainColor : isToday(date) ? AppearanceProvider.highlightColor : AppearanceProvider.backgroundColor
        property var mainColorLighter: Qt.darker(mainColor)

        property var bIsHovered : false



        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                setDisplayedItenerary(dayEvents);
                root.curDay = date;
            }
            onEntered: {
                bIsHovered = true
            }
            onExited: {
                bIsHovered = false
            }
            cursorShape: Qt.PointingHandCursor


            Rectangle {
                id: mainCircle
                radius: width
                opacity: date.getMonth() == root.curDate.getMonth() ? 1 : 0.2
                color: mainColor
                anchors.centerIn: parent
                width: parent.width > parent.height ? parent.height : parent.width
                height: width
                Component.onCompleted: {
                    let queriedEvents = CalendarEventsProvider.getEventsOnDay(dayRoot.date);
                    for (const qe of queriedEvents) {
                        dayEvents.append(qe);
                    }
                    if (isToday(date) && !root.bInitialized) {
                        setDisplayedItenerary(dayEvents);
                        root.bInitialized = true;
                    }
                }
                Rectangle {
                    width:6
                    height:6
                    radius:6
                    anchors.top:parent.top
                    visible: dayEvents.count > 0 ? true : false
                    color:AppearanceProvider.highlightColor
                }

                Text {
                    color: isToday(date) ? AppearanceProvider.highlightTextColor : AppearanceProvider.textColor
                    anchors.centerIn: parent
                    text: {
                        date.getDate();
                    }
                }

                ListModel {
                    id: dayEvents
                }

                Connections {
                    function onNeedsUpdate() {
                        let queriedEvents = CalendarEventsProvider.getEventsOnDay(dayRoot.date);
                        dayEvents.clear();
                        for (const qe of queriedEvents) {
                            dayEvents.append(qe);
                        }
                    }

                    target: CalendarEventsProvider
                }

            }

        }

        states:[
            State {
                name: "hovered"
                when: bIsHovered
                PropertyChanges {
                    mainCircle {
                        color: mainColorLighter
                    }
                }
            },
            State {
                name: "unhovered"
                when: !bIsHovered
            }
        ]

        transitions: [
            Transition {
                from: "unhovered"
                to: "hovered"
                reversible: true
                PropertyAnimation {
                    properties: "mainCircle.color"
                    duration:150
                    easing.type: Easing.InOutQuad
                }
            }
        ]

    }

}
