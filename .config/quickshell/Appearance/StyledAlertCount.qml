import QtQuick
import "./"
Rectangle {
    property var targetIcon
    property var count
    width: count >= 100 ? targetIcon.width/1.6 : targetIcon.width/2.3
    height: targetIcon.width/2.3
    radius: targetIcon.width / 2.3
    anchors.bottom: targetIcon.bottom
    anchors.right: targetIcon.right
    anchors.rightMargin: 5
    anchors.bottomMargin:5
    color: AppearanceProvider.accentColor
    visible: count > 0

    StyledText {
        property var amountSize: Math.round(parent.height * 0.45)

        anchors.centerIn: parent
        text: count
        font.pointSize: {
            amountSize > 0 ? amountSize : 2;
        }
        color: AppearanceProvider.accentTextColor
    }

}
