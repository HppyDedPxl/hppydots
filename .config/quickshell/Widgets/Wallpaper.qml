import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import QtQuick.Effects
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

    property var isInTransition: false;

    property var mainWallpaper: rendererA;
    property var backWallpaper: rendererB;

    property var swapped: false;

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

    Connections {
        target: WallpaperProvider
        function onNeedsUpdate(){
            backWallpaper.wallpaperUrl = mainWallpaper.wallpaperUrl;
            mainWallpaper.wallpaperUrl = WallpaperProvider.config.wallpapers[screen.name]
            transition.restart()
        }
    }

    SequentialAnimation {
        id: transitionAnimation
        NumberAnimation {
            id: a1

        }
    }

    WallpaperRenderer {
        id: rendererB
        anchors.fill: parent
        wallpaperUrl:""
        visible:true
    }


    MultiEffect {
        id: rendererAEffective
        source: rendererA
        anchors.fill:parent
        maskEnabled: true
        maskSource: rendererAMask
    }

    WallpaperRenderer {
        id: rendererA
        anchors.fill: parent
        visible:false
        wallpaperUrl: WallpaperProvider.config.wallpapers[screen.name]

    }

    Item {
        id: rendererAMask
        visible:false
        layer.enabled:true
        anchors.fill: rendererA

        Rectangle {
            id: maskRect
            height:parent.width
            width:parent.width
            anchors.centerIn: parent
            radius: 0
            ParallelAnimation{
                id: transition
                ScaleAnimator {
                    id:scaleAnim
                    target: maskRect
                    from: 0
                    to: 1.5
                    easing.type: Easing.InOutCubic
                    duration: 1200
                }
                NumberAnimation {
                    property: "radius"
                    target: maskRect
                    from: width
                    to: 0
                    duration: 1800
                    easing.type: Easing.Linear
                }
            }
        }   
    }



    

    // function mouseIsInScreenBounds(){
    //     if(currentMousePos[0] > screen.width || currentMousePos[0] < 0)
    //         return false
    //     if(currentMousePos[1] > screen.height || currentMousePos[1] < 0)
    //         return false
    //     return true
    // }

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
    
}
