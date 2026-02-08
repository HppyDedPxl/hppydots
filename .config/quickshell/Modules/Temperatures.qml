import "../Appearance"
import "../Services"
import QtQuick
import Quickshell

BaseModule {
    id: baseModule

    function getTemperatureIcon() {
        const iconSetup = [[85, ""], [70, ""], [45, ""], [30, ""], [0, ""]];
        for (let i = 0; i < iconSetup.length; i++) {
            if (SystemInfo.avgCpuTemp > iconSetup[i][0])
                return iconSetup[i][1];

        }
    }

    dbgName: "PackagesModule"
    content: _content
    popupContent: null
    bHasClickAction: true
    // todo:// make terminal configurable
    onClickExecCommand: ["coolercontrol"]

    Component {
        id: _content

        Rectangle {
            id: root

            anchors.fill: parent
            color: 'transparent'

            StyledText {
                anchors.centerIn: parent
                text: SystemInfo.avgCpuTemp + "°C " + baseModule.getTemperatureIcon()
                color: baseModule.textColorOnBar
            }

        }

    }

}
