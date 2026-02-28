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
    property var color
    property var gradient
    property var innerShape: shape
    property var beginPadding : 0
    property var endPadding : 0  
    property var orientation : 0


    Rectangle {
        anchors.fill : parent
        color: 'transparent'
    }

    Shape{
        id:shadowShape
        visible:true
        width:orientation % 2 == 0 ? parent.width : parent.height
        height:orientation % 2 == 0 ? parent.height : parent.width
        property var shadowSize : 6
        x:{var x=[0,-shadowSize,0,shadowSize]; return x[base.orientation]}
        y:{var x=[-shadowSize,0,shadowSize,0]; return x[base.orientation]}
        opacity:0.5
        antialiasing:true
        transform:Rotation{
            origin.x:0
            origin.y:0
            angle: 360 - orientation * 90
        }
 
        ShapePath{
            id: shadowViz
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            strokeWidth:0
            fillColor:'black'      
        }
        Instantiator {
            id: shadowInstantiator
            model: CavaListener.bucketAmount+2
            onObjectAdded: (idx,obj)=>{shadowViz.pathElements.push(obj)}
            active:true    
            PathCurve {
                required property var index
                x: (beginPadding) + ((shape.width  - (beginPadding + endPadding)) / (CavaListener.bucketAmount+1)) * index
                y:  -((index == 0 || index == CavaListener.bucketAmount+1) ? 0 : ((CavaListener.audioData[index-1]/CavaListener.valueRange)*shape.height))
                Behavior on y { NumberAnimation { duration: 50 } }
            }
        }
    }

    Shape{
        id:shape
        visible:true
        width:orientation % 2 == 0 ? parent.width : parent.height
        height:orientation % 2 == 0 ? parent.height : parent.width
        y:0  
        antialiasing:true
        transform:Rotation{
            origin.x:0
            origin.y:0
            angle: 360 - orientation * 90
        }
 
        ShapePath{
            id: viz
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            strokeWidth:0
            fillGradient:gradient      
        }
        Instantiator {
            id: instantiator
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
