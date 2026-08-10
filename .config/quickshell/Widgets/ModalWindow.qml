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
        modalRoot.visible =true
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
            modalRoot.visible = false
            contentLoader.active = false
        }
        
        // Dark translucent scrim background
        Rectangle {
            anchors.fill: parent
            color: "#00000000"

        }
    }

    Rectangle{
        id:dialogBox
        height:contentLoader.item.height
        width:contentLoader.item.width
        color:'transparent'
        anchors.centerIn:parent
        Loader {
            id: contentLoader
            active: false
            sourceComponent: widgetToShow
            onLoaded: { 
            }
        }
    }
}