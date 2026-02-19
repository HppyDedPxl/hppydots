import QtQuick
import QtQuick.Layouts
import Quickshell
import "../Appearance"
Item {
    id: root
    property var minValue:0
    property var maxValue:100
    property var value: 0
    property var step: 10
    property var color : AppearanceProvider.backgroundColor
    property var emptyColor: AppearanceProvider.inactiveColor
    property alias spacing : row.spacing
    RowLayout {
        id: row
        uniformCellSizes:true
        width:parent.width
        height:parent.height
        Repeater {
            model: Math.floor((maxValue-minValue)/step)
            Rectangle
            {
                required property var modelData
                Layout.preferredHeight:parent.height
                Layout.fillWidth:true
                color: (modelData+1)*step <= value ? root.color : root.emptyColor
                radius:AppearanceProvider.rounding/4
            }
        }
    }
}