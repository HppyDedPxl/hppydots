pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
Singleton {
    id: packagesHandler

    property var avgCpuTemp:0
    
    function initService(){
        timer.running=true
        updateData.running=true
    }

    Timer{
        id: timer
        interval: 10000
        running: false
        repeat:true
        onTriggered:{
            updateData.running=true;
        }
    }

    function getListOfValuesFromRegex(regex,input){
        let result = []
        let m;
        while ((m = regex.exec(input)) !== null) {
            if (m.index === regex.lastIndex) {
                regex.lastIndex++;
            }
            if(m.length > 1){
                result.push(m[1])
            }
        }
        return result
    }

    function evaluateSensorsOutput(input){
        // Average Cpu Core Temp:
        const regExp_coreTemp = /Core [0-9]*:[\s]*\+([0-9.]*)/gm;
        let cpuTemps = getListOfValuesFromRegex(regExp_coreTemp,input);
        let sum = 0
        for (let i = 0; i < cpuTemps.length; i++){
            sum += parseFloat(cpuTemps[i])
        }
        avgCpuTemp = Math.floor(sum/cpuTemps.length)

        // todo: cpu utilization, ram utiliziation etc.
    }

    Process {
        id: updateData
        command: ["sensors"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                evaluateSensorsOutput(this.text)
            }
        }
    }
}