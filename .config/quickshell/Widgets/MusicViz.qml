import QtQuick
import Quickshell
import Quickshell.Io
import "../Appearance"
import "../Services"
import QtQuick.Shapes
import QtQuick.Effects


Item {
    id: base
    property var running: false
    anchors.fill:parent
    property var color
    property var gradient
    property var innerShape: shape
    property var beginPadding : 0
    property var endPadding : 0  
    Rectangle {
        anchors.fill : parent
        color: 'transparent'
    }
    Shape{
        id:shape
        visible:true
        width:parent.width
        height:parent.height
        y:shape.height    
        antialiasing:true
        ShapePath{
            id: viz
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            strokeWidth: 3
            strokeColor: AppearanceProvider.backgroundColorSecondary
            strokeStyle: ShapePath.SolidLine
            fillGradient:gradient
        }
        Instantiator {
            id: insti
            model: CavaListener.bucketAmount+2
            onObjectAdded: (idx,obj)=>{viz.pathElements.push(obj)}
            active:true    
            PathCurve {
                required property var index
                x: (beginPadding) + ((shape.width  - (beginPadding + endPadding)) / (CavaListener.bucketAmount+1)) * index
                y:  -((index == 0 || index == CavaListener.bucketAmount+1) ? 0 : ((CavaListener.audioData[index-1]/CavaListener.valueRange)*shape.height))
                Behavior on y { NumberAnimation { duration: 50 } }
            }
        }
    }
}
