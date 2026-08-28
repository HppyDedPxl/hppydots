pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Polkit
import Qt.labs.folderlistmodel

Singleton {
    id: _

    property var config: ({})
    property var configPath: "./../config"
    property var configFileName: "calendar.json"
    FileView {
        id: fvConfig
        path: Qt.resolvedUrl(configPath + "/" + configFileName)
        atomicWrites: true
        watchChanges:true
        onLoaded:  _.config=JSON.parse(fvConfig.text())
        onFileChanged: {
            _.config=JSON.parse(fvConfig.text())
        }
    }

    function urlToPathString(url){
        return url.toString().substring(7);
    }


    property var jsPath : "./../events.json"
    property var updateScriptPath: "./script.py"
    readonly property var eventModel: events

    signal needsUpdate()

    function fromJSON(data) {
        let es = JSON.parse(data);
        events.clear()
        for (const e of es){
            events.append(e)
        }
        needsUpdate();
    }

    function sameDay(d1, d2) {
        return d1.getFullYear() === d2.getFullYear() &&
            d1.getMonth() === d2.getMonth() &&
            d1.getDate() === d2.getDate();
        }

    
    function isBetweenNr(v,a,b) {

        return v >= a && v <= b;
    }

    function isBetweenTime(v,a,b) {


        let ibt = isBetweenNr(v.getFullYear(),a.getFullYear(),b.getFullYear()) &&
        isBetweenNr(v.getMonth(),a.getMonth(),b.getMonth()) &&
        isBetweenNr(v.getDate(),a.getDate(),b.getDate());

        return ibt;
        
    }

    function getEventsOnDay(dateTime){
        let found = [];
        let dateTimeUtc = Math.floor((dateTime).getTime());
        for (let i = 0; i < events.count; ++i) {
            let cur = events.get(i);
            let begin = new Date(parseFloat(cur.start*1000))
            let end = new Date(parseFloat(cur.end*1000-1))
            let now = new Date(dateTimeUtc)  
            if( isBetweenTime(now,begin,end)) {
                found.push(cur);
            }
        }
        return found
    }

    function sync(){
        let command = [config.python_command, urlToPathString(Qt.resolvedUrl(config.query_calendar_script))]
        console.log("sync against: " + urlToPathString(Qt.resolvedUrl(config.output_file)))
        command = command.concat(["-t", urlToPathString(Qt.resolvedUrl(config.output_file))])
        command = command.concat(["-b", "2026-01-01"])
        command = command.concat(["-e", "2028-01-01"])
        command = command.concat(["-l"])
        command = command.concat(config.calendar_links)
        
        let str = ""
        for (let i = 0; i < command.length; i++){
            str += command[i] + " "
        }
        console.log(str)
        syncCalendar.command = command
        syncCalendar.running = true  
    }

    ListModel {
        id: events
    }

    Process {
        id: syncCalendar
        running: false
        stdout: StdioCollector {
            onStreamFinished:{
                if (this.text == "finished"){
                    conole.log("Sync Calendar Done")
                    calendarEvents.reload();    
                }
            }
        }
    }

    FileView {
        id: calendarEvents
        path: urlToPathString(Qt.resolvedUrl(config.output_file))
        atomicWrites: true
        watchChanges:true
        onLoaded: {
            _.fromJSON(calendarEvents.text())
        }
        onFileChanged: {
            calendarEvents.reload()
            _.fromJSON(calendarEvents.text())
        }
    }

}