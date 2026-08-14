pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Polkit
import Qt.labs.folderlistmodel

Singleton {
    id: _

    property var config: ({})
    property var writeScriptPath: "./../Scripts/write_config.sh"
    property var configPath: "./../config"
    property var configFileName: "wallpaper.json"
    property var postSetScript: "/home/Alexander/dotfiles/globalscripts/wallpaper/post_set_wallpaper.sh"

    signal needsUpdate()

    function getWallpaperPathForScreen(screen){
        if(config.wallpapers === undefined || config.wallpapers[screen.name] === undefined) return "";
        return Qt.resolvedUrl(config.wallpapers[screen.name])
    }

    function getWallpaperThumbnailPathForScreen(screen){
        if(config.wallpapers === undefined || config.wallpapers[screen.name] === undefined) return "";
        let uri = Qt.resolvedUrl(config.wallpapers[screen.name]).toString();
        let i = uri.lastIndexOf('/');
        let thumbsPath = uri.substring(0,i) + "/thumbs"
        let filename = uri.slice(i);
        thumbsPath += filename + ".thumb"
        return thumbsPath;
    }

    function urlToPathString(url){
        return url.toString().substring(7);
    }


    function setDefaultWallpaperFolder(path){
        _.config.defaultWallpaperFolder = urlToPathString(path);
        saveConfig()
    }


    function fromJSON(data){
        config = JSON.parse(data)
    }


    function setWallpaper(screen,path,callPostSetScript){
        console.log("call post set wallpaper script with " + callPostSetScript)
        if(_.config.wallpapers === undefined)
            _.config.wallpapers = {}
        _.config.wallpapers[screen.name] = urlToPathString(path)
        if(callPostSetScript == true && _.config.postSetScript != undefined && _.config.postSetScript != ""){
            proc_postSetWallpaper.command = ["sh",_.config.postSetScript,"",  urlToPathString(path)]
            proc_postSetWallpaper.running = true
        }
        needsUpdate()
        saveConfig()
    }

    function saveConfig(){
        wpConfig.setText(JSON.stringify(_.config))
    }
    
    function setPostSetScriptPath(path) {
        _.config.postSetScript = path
        saveConfig();
    }

    function generateThumbnailsInFolder(path, onDone){
        proc_generate_thumbs.command = ["sh",urlToPathString(Qt.resolvedUrl("./../Scripts/generate_wallpaper_thumbs.sh")), urlToPathString(path)]
        proc_generate_thumbs.onDoneCallback = onDone
        proc_generate_thumbs.running = true

    }

    Process {
        id: proc_generate_thumbs
        property var onDoneCallback
        running: false
        stdout: StdioCollector {
            onStreamFinished:{
                if (proc_generate_thumbs.onDoneCallback !== undefined)
                {
                    proc_generate_thumbs.onDoneCallback()
                }
            }
        }
    }

    Process {
        id: proc_saveConfig
        running:false
    }

    Process {
        id: proc_postSetWallpaper
        running:false
    }

    FileView {
        id: wpConfig
        path: Qt.resolvedUrl(configPath + "/" + configFileName)
        atomicWrites: true
        watchChanges:true
        onLoaded: _.fromJSON(wpConfig.text())
        onFileChanged: {
            reload()
            _.fromJSON(wpConfig.text())
        }
    }
}