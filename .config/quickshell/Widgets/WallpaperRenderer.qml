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


Rectangle
{
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

    property var wallpaperUrl : ""

    onWallpaperUrlChanged:{
        setupVideoRendering()
    }

    color:'transparent'
    anchors.fill:parent
    Component.onCompleted:{
        setupVideoRendering()
    }

    Image {
        id: bgImage
        height: parent.height
        width: parent.width
        fillMode: Image.PreserveAspectCrop
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