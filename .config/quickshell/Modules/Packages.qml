import "../Appearance"
import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io // for Process

BaseModule {
    id: baseModule
    dbgName:"PackagesModule"
    content: _content
    popupContent: null
     bHasClickAction:true
     // todo:// make terminal configurable
     onClickExecCommand: ["sh","-c","kitty -e pacseek -u"]

    Component {
        id: _content

        Rectangle {
            id: root
            anchors.fill:parent
            color: 'transparent'
            StyledBarIcon {
                id: icon
                text: "󰏗"
            }

            StyledAlertCount {
                targetIcon: icon
                count: PackagesInfo.amountPendingPackageUpdates
            }
        }
    }

    Component {
        id: _popupContent
        Rectangle {
            width: 300
            height: 300
        }

    }

}
