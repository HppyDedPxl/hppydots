import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import QtMultimedia
import "../Services"
import "../Appearance"

PanelWindow{
    id: wallpaperMain
    screen: scope.modelData
    exclusiveZone:0
    WlrLayershell.layer: WlrLayer.Bottom
    property var currentMousePos:[0,0]
    color:'transparent'
    exclusionMode: ExclusionMode.Ignore
    property var themeExclusionZonesTop:0
    property var themeExclusionZonesBottom:0
    property var themeExclusionZonesLeft:0
    property var themeExclusionZonesRight:0

    property var wallpaperUrl: WallpaperProvider.config.wallpapers[screen.name]
    property var wallpaperFolder: "file:///home/Alexander/wallpaper"
    property var scriptToRun: "/home/Alexander/dotfiles/globalscripts/wallpaper/post_set_wallpaper.sh"

   Connections {
    target: WallpaperProvider
    function onNeedsUpdate(){
        // Forcefully set this again as sometimes the array based binding does
        // not properly work when a js object is the target.
        wallpaperUrl = WallpaperProvider.config.wallpapers[screen.name]
    }
   }
    
    function isVideo(file){
        let psplit = file.toString().split('.');
        return psplit[psplit.length-1] == "mp4";
    }

    function setupVideoRendering(){
        let isVid = isVideo(wallpaperUrl)
        if(isVid){
            player.source = wallpaperUrl
            player.play()
        }
        else{
            player.source = ""
            player.stop()
        }
    }

    onWallpaperUrlChanged:{
        setupVideoRendering()
    }

    function mouseIsInScreenBounds(){
        if(currentMousePos[0] > screen.width || currentMousePos[0] < 0)
            return false
        if(currentMousePos[1] > screen.height || currentMousePos[1] < 0)
            return false
        return true
    }

    // Process{
    //     id: getMousePos
    //     command: ["hyprctl","cursorpos"]
    //     running:true
    //     stdout: StdioCollector {
    //         onStreamFinished:{
    //             let res = this.text.split(',')
    //             currentMousePos[0] = parseFloat(res[0]) - screen.x
    //             currentMousePos[1] = parseFloat(res[1]) - screen.y
    //             if(mouseIsInScreenBounds()){
                   
    //                 bgImage.x = ((screen.width/2) - currentMousePos[0])/(screen.width/2) * 50
    //                 bgImage.y = ((screen.height/2) - currentMousePos[1])/(screen.height/2) * 50
    //             }
           
    //         }
    //     }
    // }

    // Timer {
    //     interval: 200
    //     running:true
    //     repeat:true
    //     onTriggered:{
    //         getMousePos.running=true
    //     }
    // }
    anchors {
        top:true
        bottom:true
        left:true
        right:true
    }
    margins {
        top:-themeExclusionZonesTop
        bottom:-themeExclusionZonesBottom
        left:-themeExclusionZonesLeft
        right:-themeExclusionZonesRight
    }

    Rectangle{
        color:'transparent'
        anchors.fill:parent
        Component.onCompleted:{
            setupVideoRendering()
        }

        Image {
            id: bgImage
            height:parent.height
            width:parent.width
            fillMode: Image.PreserveAspectFit
            
            
            // x : {(Math.abs((screen.width/2) - currentMousePos[0])/(screen.width/2)) * 30}
            // y : {(Math.abs((screen.height/2) - currentMousePos[1])/(screen.height/2)) * 30}

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
            source:wallpaperUrl

            // Optional video player?
            MediaPlayer {
                id: player
                autoPlay: false
                loops: MediaPlayer.Infinite
                videoOutput: output

            }
            VideoOutput {
                id: output
                anchors.fill:parent
            }
        }
    }  
}
