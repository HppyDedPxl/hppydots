import Quickshell
import QtQuick
import QtQuick.Layouts
import "../Appearance"
BaseModule {
    id: baseModule
    dbgName: "ccModule"
    width:parent.height
    content: _content
    popupContent: _popupContent
    Component {
        id: _content
        StyledSidebarDock {  
            content: StyledBarIcon {
                anchors.fill:parent
                text : ""
            }
        }
    }

    Component{
        id: _popupContent
        Item {
            width:300
            height:400
            Item{
                anchors.top:parent.top
                anchors.bottom:parent.bottom
                anchors.left:parent.left
                anchors.right:parent.right
                anchors.margins:10
                RowLayout {
                    width:parent.width
                    spacing:10
                    height: width/5
                    StyledButton{
                        Layout.preferredWidth:parent.width/5
                        Layout.preferredHeight:width
                        text:"󰍃"
                        fontSize:30
                    }
                    StyledButton{
                        Layout.preferredWidth:parent.width/5
                        Layout.preferredHeight:width
                        text:""
                        fontSize:30
                    }
                    StyledButton{
                        Layout.preferredWidth:parent.width/5
                        Layout.preferredHeight:width
                        text:"󰑓"
                        fontSize:30
                    }
                    StyledButton{
                        Layout.preferredWidth:parent.width/5
                        Layout.preferredHeight:width
                        text:""
                        fontSize:30
                    }

                }
            } 
        }
    }
}