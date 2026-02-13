
import "./"
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import QtQuick.Shapes

Slider {
    id: control
    width:300
    property var thickness: 15
    property var target
    property var barHeight : 20
    property var updateTime:()=>{
         control.value = target.position / target.length;
    }
    property var forceUpdate: false

     function lengthFormat(d){
        let m = Math.floor(d/60)
        return m.toString().padStart(2,"0") + ":" + Math.floor(d-m*60).toString().padStart(2,"0")
    }

    property var getTimeElapsedString: ()=>{
        return lengthFormat(control.value*target.length)
    }

    property var getTimeRemainingString: ()=>{
        return lengthFormat(target.length - (control.value*target.length))
    }

    onMoved:{
        if(target) 
            target.position = (control.value * (target.length))
    }

    Timer {
        id: timingUpdate
        interval: 500
        running: target ? target.isPlaying : false
        repeat:true
        onTriggered: {
            control.value = target.position / target.length;
        }
    }
   

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        width: control.availableWidth
        height: 1
        radius: AppearanceProvider.rounding
        color: AppearanceProvider.inactiveColor
      
        Rectangle{
            width:parent.width* control.value
            y: -barHeight/2
            color: 'transparent'
            clip:true
            height:barHeight
            Shape {
            NumberAnimation {
                id: squiggleAnim
                target:shape
                property:"x"
                from:-shape.step * 2
                to:0
                duration:1000
                running:true
                onFinished: {
                    squiggleAnim.running = true
                }
            }
            NumberAnimation {
                id: squiggleAnim2
                target:shape
                property:"radi"
                from:35
                to:45
                duration:1000
                running:true
                onFinished: {
                    squiggleAnim3.running = true
                }
                easing.type : Easing.InOutCubic

            }
            NumberAnimation {
                id: squiggleAnim3
                target:shape
                property:"radi"
                from:45
                to:35
                duration:1000
                running:false
                onFinished: {
                    squiggleAnim2.running = true
                }
                easing.type : Easing.InOutCubic
            }
            id:shape
            x:0
            y:parent.height/2
            width:180
            height:180
            preferredRendererType: Shape.CurveRenderer
            property var step: 20
            property var radi : 15
            ShapePath {
            strokeColor: AppearanceProvider.backgroundColor
            strokeWidth: 5
            fillColor:'transparent'
 
            PathArc {
               relativeX:shape.step
               radiusX:shape.radi
               radiusY:shape.radi

            }
            PathArc {
               relativeX:shape.step
                radiusX:shape.radi
               radiusY:shape.radi
               direction : PathArc.Counterclockwise
            }
            PathArc {
               relativeX:shape.step
               radiusX:shape.radi
               radiusY:shape.radi

            }
            PathArc {
               relativeX:shape.step
                radiusX:shape.radi
               radiusY:shape.radi
               direction : PathArc.Counterclockwise
            }
            PathArc {
               relativeX:shape.step
               radiusX:shape.radi
               radiusY:shape.radi

            }
            PathArc {
               relativeX:shape.step
                radiusX:shape.radi
               radiusY:shape.radi
               direction : PathArc.Counterclockwise
            }
            PathArc {
               relativeX:shape.step
               radiusX:shape.radi
               radiusY:shape.radi

            }
            PathArc {
               relativeX:shape.step
                radiusX:shape.radi
               radiusY:shape.radi
               direction : PathArc.Counterclockwise
            }
                 PathArc {
               relativeX:shape.step
               radiusX:shape.radi
               radiusY:shape.radi

            }
            PathArc {
               relativeX:shape.step
                radiusX:shape.radi
               radiusY:shape.radi
               direction : PathArc.Counterclockwise
            }
            PathArc {
               relativeX:shape.step
               radiusX:shape.radi
               radiusY:shape.radi

            }
            PathArc {
               relativeX:shape.step
                radiusX:shape.radi
               radiusY:shape.radi
               direction : PathArc.Counterclockwise
            }
            PathArc {
               relativeX:shape.step
               radiusX:shape.radi
               radiusY:shape.radi

            }
            PathArc {
               relativeX:shape.step
                radiusX:shape.radi
               radiusY:shape.radi
               direction : PathArc.Counterclockwise
            }
 

        }
        }
        
        }
        
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: control.thickness
        implicitHeight: control.thickness
        radius: 13
        color: AppearanceProvider.backgroundColor
        border.color: 'transparent'
    }
}


