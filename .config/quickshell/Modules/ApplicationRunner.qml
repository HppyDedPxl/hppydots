import QtQuick
import Quickshell
import QtQuick.Controls
import "../Appearance"
import "../Services"
import "../Widgets"
import "./"
import QtQuick.Layouts
BaseModule{
    id:baseModule
    dbgName: "appRunner"
    content : _content
    popupContent: _popupContent
    property var selectedAppIndex:0

    Component{
        id:_content
        Rectangle {
            height: parent.height
            width:100
            color:'transparent'
            StyledText{
                text:""
            }
        }
    }

    function findByName(in_name){
        let entries = [];
        selectedAppIndex = 0
        if(in_name.length == 0){
            return entries
        }

        for (let i = 0; i < DesktopEntries.applications.values.length; i++){
            if(DesktopEntries.applications.values[i].name.toLowerCase().startsWith(in_name)){
                entries.push(DesktopEntries.applications.values[i])            
            }
        }
        return entries
    }

    ScriptModel {
        id: displayDesktopEntries
        values: displayDesktopEntries.values
    }

    Component{
        id:_popupContent
        Rectangle{
            color:'transparent'
            width:700
            height:500

            property var getAutoFocusItem:()=>{
                return textInput
            }

            TextField {
                height:48
                id:textInput
                anchors.top: parent.top
                anchors.left : parent.left
                anchors.right: parent.right
                anchors.leftMargin:25
                anchors.rightMargin:25
                anchors.topMargin:15
                placeholderText: "Type Application Name..."
                color:AppearanceProvider.inactiveTextColor
                leftInset:-10
                rightInset:-10
                background: Rectangle {
                    color:AppearanceProvider.inactiveColor
                    radius:AppearanceProvider.rounding
                }

                Keys.onEscapePressed: {
                        // Cancel the save, and deselect the text input
                        textInput.text=""
                        baseModule.closePopup()
                        displayDesktopEntries.values = []
                    }
                Keys.onDownPressed:{
                    baseModule.selectedAppIndex= Math.max(0,Math.min(baseModule.selectedAppIndex+1,displayDesktopEntries.values.length-1))
                }
                Keys.onUpPressed:{
                    baseModule.selectedAppIndex= Math.max(0,Math.min(baseModule.selectedAppIndex-1,displayDesktopEntries.values.length-1))
                }
                 Keys.onReturnPressed:{
                    if(displayDesktopEntries.values[baseModule.selectedAppIndex] != undefined && displayDesktopEntries.values[baseModule.selectedAppIndex] != null)
                        displayDesktopEntries.values[baseModule.selectedAppIndex].execute()
                    textInput.text=""
                    displayDesktopEntries.values = []
                    baseModule.closePopup()
                }
                onTextEdited:{
                    displayDesktopEntries.values = findByName(this.text)
                }
            }
            
            ScrollView {
                id: listView
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom : parent.bottom
                anchors.top: textInput.bottom
                anchors.leftMargin:10
                anchors.bottomMargin:10
                anchors.rightMargin:10
                anchors.topMargin:10
                property list<Item> _widgets:[]
                spacing: 15
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                contentWidth: parent.width
                contentHeight: innerRect.height
                Rectangle{
                    id: innerRect
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top:parent.top
                    anchors.bottom:parent.bottom
                    anchors.leftMargin:15
                    anchors.rightMargin:40
                    height: displayDesktopEntries.values.length * 60  
                    ColumnLayout {
                        id: col
                        anchors.top:parent.top
                        anchors.left:parent.left
                        anchors.bottom:parent.bottom
                        anchors.right:parent.right
                        Repeater {
                            model : displayDesktopEntries        
                            DesktopEntryWidget{      
                                required property var modelData
                                required property var index
                                _data: modelData
                                width:innerRect.width
                                isFocused: index == baseModule.selectedAppIndex
                                
                            }          
                        }
                }
                }
                
            }
        }
    }
}