import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

PanelWindow{
    screen: scope.modelData
    exclusiveZone:0
    WlrLayershell.layer: WlrLayer.Bottom
    property var currentMousePos:[0,0]
    
    
    function mouseIsInScreenBounds(){
        if(currentMousePos[0] > screen.width || currentMousePos[0] < 0)
            return false
        if(currentMousePos[1] > screen.height || currentMousePos[1] < 0)
            return false
        return true
    }

    Process{
        id: getMousePos
        command: ["hyprctl","cursorpos"]
        running:true
        stdout: StdioCollector {
            onStreamFinished:{
                let res = this.text.split(',')
                currentMousePos[0] = parseFloat(res[0]) - screen.x
                currentMousePos[1] = parseFloat(res[1]) - screen.y
                if(mouseIsInScreenBounds()){
                   
                    bgImage.x = ((screen.width/2) - currentMousePos[0])/(screen.width/2) * 50
                    bgImage.y = ((screen.height/2) - currentMousePos[1])/(screen.height/2) * 50
                    console.log(bgImage.x)
                }
           
            }
        }
    }

    Timer {
        interval: 200
        running:true
        repeat:true
        onTriggered:{
            getMousePos.running=true
        }
    }
    anchors {
        top:true
        bottom:true
        left:true
        right:true
    }

    Rectangle{
    anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.margins:-40
        Image {
        id: bgImage
        height:parent.height
        width:parent.width
        
        x : {(Math.abs((screen.width/2) - currentMousePos[0])/(screen.width/2)) * 30}
        y : {(Math.abs((screen.height/2) - currentMousePos[1])/(screen.height/2)) * 30}

        Behavior on x{
            NumberAnimation{
                duration:500
            }
        }
        Behavior on y{
            NumberAnimation{
                duration: 500
            }
        }

 
        source:"file://home/Alexander/wallpaper/mountain.jpg"
    }

    }
    
}