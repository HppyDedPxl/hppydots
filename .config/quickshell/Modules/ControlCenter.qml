import Quickshell
import QtQuick
import "../Appearance"
BaseModule {
    id: baseModule
    dbgName: "ccModule"

    content: _content
    popupContent: _popupContent

    Component {
        id: _content
        StyledSidebarDock {
            content: 
                StyledBarIcon {
                    anchors.fill:parent
                    text : ""
                }
        }
    }
}