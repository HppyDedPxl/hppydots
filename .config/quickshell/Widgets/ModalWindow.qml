import Quickshell
import QtQuick
PanelWindow
{
    id: modalRoot
    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    anchors.right: true
    exclusionMode: ExclusionMode.Ignore 
    color: 'transparent'
    visible: false
    screen: scope.modelData
    property var widgetToShow : null

    function show(widget){
        modalRoot.visible = true
        modalRoot.widgetToShow = widget;
        contentLoader.active = true
        modalRoot.forceActiveFocus();
        modalRoot.raise();
		modalRoot.requestActivate();
    }
    
     // Background overlay that dismisses the dialog on click
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        
        onClicked: {
            dialogBox.displaying = false
        }
        
        // Dark translucent scrim background
        Rectangle {
            anchors.fill: parent
            color: '#96313030'

        }
    }

    Rectangle{
        id:dialogBox
        height:contentLoader.item.height
        width:contentLoader.item.width
        color:'transparent'
        //anchors.centerIn:parent
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin:50
        property var displaying : false
        transform: Scale {
            xScale: 0
            yScale: 0
            origin.x:0.5
            origin.y:0.5
        }
        Loader {
            id: contentLoader
            active: false
            sourceComponent: widgetToShow
            onLoaded: { 
                dialogBox.displaying = true;
            }
        }
        states: [
            State {
                name: "open"
                when: dialogBox.displaying
                PropertyChanges {
                    dialogBox {
                        transform : Scale{
                            xScale: 1
                            yScale: 1
                        }
                    }
                }
            },
            State {
                name: "closed"
                when: !dialogBox.displaying
                  PropertyChanges {
                    dialogBox {
                       transform : Scale{
                            xScale: 0
                            yScale: 0
                        }
                    }
                }
            }
        ]
        transitions: [
            Transition {
                from: "closed"
                to: "open"
                ScaleAnimator {
                    target: dialogBox
                    from: 0
                    to: 1
                    easing.type: Easing.OutElastic
                    easing.amplitude: 0.7
                    easing.period: 1.2
                    duration: 700
                }
            },
            Transition {
                from: "open"
                to: "closed"
                  SequentialAnimation{
                  ScaleAnimator {
                    target: dialogBox
                    from: 1
                    to: 0
                    easing.type: Easing.InOutCubic
                    duration: 400
                    }
                    ScriptAction{
                        script:{      
                        modalRoot.visible= false
                        contentLoader.active = false
                    }}
                  }
            }
        ]
    }
}