import QtQuick
import Quickshell
import Quickshell.Io
import "../Appearance"
import "../Services"
import QtQuick.Shapes


Item {
    id: base
    property var running: false
    anchors.fill:parent
    property var color
    property var gradient
    property var innerShape: shape
    
    Rectangle {
        anchors.fill : parent
        color: 'transparent'
    }

    // StyledButton {
    //     anchors.centerIn : parent
    //     width: 50
    //     height: 50
    //     text : base.running?"stop":"start"
    //     onClick: ()=>{
    //         base.running = !base.running;
    //         if(base.running){
    //             CavaListener.startListening()
    //             shape.visible = true;
    //             insti.active=true
    //         }
    //         else{
    //             CavaListener.stopListening()
    //             insti.active=true

    //         }
    //     }
    // }
    Shape{
        visible:true
        id:shape
        width:parent.width
        height:parent.height
        y:shape.height    
        ShapePath{
            id: viz
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            strokeWidth: 0
            strokeStyle: ShapePath.SolidLine
            fillGradient:gradient
        }

        Instantiator {
            id: insti
            model: CavaListener.bucketAmount+2
            onObjectAdded: viz.pathElements.push(object)
            active:true    
            PathCurve {
                required property var index
                x: (shape.width / (CavaListener.bucketAmount+1)) * index
                y:  -((index == 0 || index == CavaListener.bucketAmount+1) ? 0 : ((CavaListener.audioData[index-1]/CavaListener.valueRange)*shape.height))
                Behavior on y { NumberAnimation { duration: 50 } }
            }
        }
    }

    // Repeater {
    //     model : 10
    //     Rectangle {
    //         id:bar
    //         required property var modelData
    //         required property var index
    //         x: (parent.width / 10) * index
    //         y: 0
    //         width: (parent.width / 10)
    //         height: CavaListener.audioData[index]
    //         color: 'green'
    //         Behavior on height { NumberAnimation { duration: 50 } }
    //     }
    // }
    
    
}