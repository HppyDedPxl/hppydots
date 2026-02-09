import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import "../Appearance"
BaseModule {
    id: baseModule

    dbgName:"TrayModule"
    property var trayWidth: 185
    property var itemColumns: 6
    property QsMenuAnchor openedMenu: menuAnchor
    width:45
    function getTrayItemsFiltered() {
        var TrayItems = [];
        for (var i = 0; i < SystemTray.items.values.length; i++) {
            if (SystemTray.items.values[i].icon !== undefined)
                TrayItems.push(SystemTray.items.values[i]);

        }
        return TrayItems;
    }

    content: _content
    popupContent: _popupContent

    Component {
        id: _content

        Rectangle{
            anchors.fill:parent
            color:'transparent'
            property var dynFontSize: Math.round(parent.height * 0.4)
            StyledText{
                anchors.centerIn:parent
                text:"\udb84\ude96"
                color: baseModule.textColorOnBar
                font.pointSize: { dynFontSize > 0 ? dynFontSize : 14 }
            }
        }

    }

    // Dummy Elements to Anchor the context menu for the tray icons in
    // ~~ Begin
    QsMenuAnchor {
        id: menuAnchor
        onClosed: {
            win.visible = false;
            baseModule.bInhibitClose = false;
        }
    }

    PopupWindow {
        id: win
        anchor.window: topBar
        implicitWidth: 1
        implicitHeight: 1
        visible: false
        color: 'transparent'
        Text {
        }
    }
    // ~~ End

    Component {
        id: _popupContent
        Rectangle {
            property var iconSizeOffset: 50;

            height: (trayWidth / itemColumns) * (SystemTray.items.values.length / itemColumns + 1)
            width: trayWidth
            color: 'transparent'

            GridLayout {
                anchors.top:parent.top
                anchors.left:parent.left
                anchors.right:parent.right
                anchors.bottom:parent.bottom
                anchors.margins: 10
                anchors.topMargin:20
                columns: itemColumns
                uniformCellHeights: true
                uniformCellWidths: true
                rowSpacing: 10
           
                Repeater {
                    model: getTrayItemsFiltered().length
                    Image {
                        id: image
                        Layout.preferredHeight: (trayWidth-iconSizeOffset) / itemColumns
                        Layout.maximumHeight: (trayWidth-iconSizeOffset) / itemColumns
                        Layout.preferredWidth:(trayWidth-iconSizeOffset) / itemColumns
                        Layout.maximumWidth:(trayWidth-iconSizeOffset) / itemColumns
                        fillMode: Image.PreserveAspectFit
                        source: SystemTray.items.values[index].icon

                        MouseArea {
                            anchors.fill: parent
                            enabled: true
                            hoverEnabled: true
                            visible: true
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked: {
                                if (mouse.button == Qt.RightButton && SystemTray.items.values[index].hasMenu) {
                                    baseModule.bInhibitClose = true;
                                    menuAnchor.menu = SystemTray.items.values[index].menu;
                                    menuAnchor.anchor.window = win;
                                    var global = image.mapToGlobal(image.x, image.y);
                                    win.anchor.rect.x = global.x;
                                    win.anchor.rect.y = global.y;
                                    win.visible = true;
                                    menuAnchor.open();
                                } else {
                                    SystemTray.items.values[index].activate();
                                }
                            }
                        }
                    }
                }
                
                // Super weird and hacky buffer to make sure that there are at least x tray icons that 
                // overflow and are invisible but force the GridLayout to layout properly...
                Repeater{
                    model: itemColumns
                    Rectangle{
                    Layout.fillWidth:true
                                        Layout.preferredHeight: (trayWidth-iconSizeOffset) / itemColumns
                        Layout.maximumHeight: (trayWidth-iconSizeOffset) / itemColumns
                    color:'transparent'
                }
                }

            }
         

        }

    }

}
