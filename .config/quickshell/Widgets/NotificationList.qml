import "../Appearance"
import "../Services"
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

Item{
    ScrollView {
    id: listView
    anchors.fill:parent
    anchors.leftMargin:10
    anchors.bottomMargin:10
    anchors.rightMargin:10
    anchors.topMargin:10
    property list<Item> _widgets:[]
    spacing: 15
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    contentWidth: parent.width
    contentHeight: innerRect.height
    Rectangle {
        id: innerRect
        color:'transparent'
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin:15
        anchors.rightMargin:40
        height: listView._widgets.length > 0 ? listView._widgets[listView._widgets.length-1].item.y + listView._widgets[listView._widgets.length-1].item.height : 0
        
        Repeater {
        id: rp
        model: NotificationHandler.getNotificationBacklog()

        onItemAdded:(idx,item)=> {
            listView._widgets.push(item)
        }
        onItemRemoved:(idx)=>{
            listView._widgets.splice(idx,1)
        }
        Loader {
            required property var modelData
            required property var index
            active: true
            function getYForIndex(idx){
                if(idx == 0){
                    return 0
                } 
                if(listView._widgets[idx-1] == undefined){
                    return 0
                }
                return listView._widgets[idx-1].item.y + listView._widgets[idx-1].item.height + listView.spacing
            }
            sourceComponent: Component {
                NotificationCard {
                    id: _popupInside
                    notification: modelData            
                    width: innerRect.width
                    y: getYForIndex(index)

                    Behavior on y {
                        SequentialAnimation {
                            NumberAnimation {
                                duration: 200
                            }
                        }
                    }
                }
            }
        }

    }
    }
 
}
}
