import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: systemInfo

    property var avgCpuTemp: 0
    property var avgCpuLoad: 0
    property var lastCpuTotal: 0
    property var lastCpuIdle: 0
    property var memFree: 0
    property var memTotal: 0
    property var batteryStatus: "Not charging"
    property var batteryPercentage: 100
    property var activeWindow : {}

    property var bSupportsBacklightControl : true
    property var currentBacklightBrightness : 0

    property var bHasBattery : true

    function initService() {
        timer.running = true;
        timerFast.running = true;
        queryAll()
    }

    function queryAll(){
        temperatureCheck.running = true;
        cpuramcheck.running = true;
        memcheck.running = true;
        if(bHasBattery){
            batteryStatusCheck.running = true
            batteryCapacityCheck.running = true
        }
    }

    function setBacklightBrightness(pct){
        currentBacklightBrightness = pct
        sendProcess.command = ["brightnessctl","-c","backlight","set",pct+"%"]
        sendProcess.running = true
    }

    function getListOfValuesFromRegex(regex, input) {
        let result = [];
        let m;
        while ((m = regex.exec(input)) !== null) {
            if (m.index === regex.lastIndex)
                regex.lastIndex++;

            if (m.length > 1)
                result.push(parseFloat(m[1]));

        }
        return result;
    }

    function evaluateSensorsOutput(input) {
        // Average Cpu Core Temp:
        const regExp_coreTemp = /Core [0-9]*:[\s]*\+([0-9.]*)/gm;
        const regExp_coreTempAlt = /CPU:[\s]*\+([0-9.]*)/gm; // alternative format e.g. for thinkpads
        let cpuTemps = getListOfValuesFromRegex(regExp_coreTemp, input);
        if (cpuTemps.length == 0){
            cpuTemps = getListOfValuesFromRegex(regExp_coreTempAlt, input);
        }
        let sum = 0;
        for (let i = 0; i < cpuTemps.length; i++) {
            sum += parseFloat(cpuTemps[i]);
        }
        avgCpuTemp = Math.floor(sum / cpuTemps.length);
    }

    function evaluateTopOutput(input) {
        const regExp_cpuUtils = /(\d+)/gm;
        let cpu = getListOfValuesFromRegex(regExp_cpuUtils, input);
        let idle = cpu[3];
        let total = cpu.slice(0, 4).reduce((a, b) => {
            return a + b;
        }, 0);
        avgCpuLoad = 1 - ((idle - lastCpuIdle) / (total - lastCpuTotal));
        lastCpuIdle = idle;
        lastCpuTotal = total;
    }

    function evaluateFreeOutput(input) {
        const regExp_free = /(\d+)/gm;
        let mem = getListOfValuesFromRegex(regExp_free, input);
        memTotal = mem[0];
        memFree = mem[1];
    }

    function evaluateBrightnessOutput(input){
        const regExp_brightness = /\((\d*)\%\)/gm
        let b = getListOfValuesFromRegex(regExp_brightness,input)
        currentBacklightBrightness = b[0]
    }

    Timer {
        id: timer
        interval: 2000 // check every 2 seconds
        running: false
        repeat: true
        onTriggered: {
            queryAll();
        }
    }

    // more accurate active window scan
    Timer {
        id: timerFast
        interval: 750 
        running: false
        repeat: true
        onTriggered: {
            getActiveWindowData.running = true
            if(bSupportsBacklightControl){
                getBacklightData.running = true
            }
        }
    }

    Process {
        id: batteryStatusCheck
        command: ["cat", "/sys/class/power_supply/BAT0/status"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                systemInfo.batteryStatus = String(this.text).replace('\n','')
            }
        }
        stderr: StdioCollector {
            onStreamFinished: {
                if(this.data != ""){
                    console.log("Error " + this.data + " getting battery state, stop queriying battery!");
                    bHasBattery = false;
                }
            }
        }
    }
    Process {
        id: batteryCapacityCheck
        command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                systemInfo.batteryPercentage = parseFloat(this.text)
            }
        }
    }

    Process {
        id: temperatureCheck
        command: ["sensors"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                evaluateSensorsOutput(this.text);
            }
        }
    }

    Process {
        id: cpuramcheck
        command: ["sh", "-c", "cat /proc/stat | grep cpu"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                evaluateTopOutput(this.text);
            }
        }
    }

    Process {
        id: memcheck
        command: ["free"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                evaluateFreeOutput(this.text);
            }
        }
    }

    Process {
        id: getActiveWindowData
        command: ["hyprctl","-j","activewindow"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                activeWindow = JSON.parse(this.text)
            }
        }
    }

    Process {
        id: getBacklightData
        command: ["brightnessctl","-c","backlight","info"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                if(this.text !== ""){
                    bSupportsBacklightControl = true
                    evaluateBrightnessOutput(this.text)
                }
            }
        }
        stderr: StdioCollector {
            onStreamFinished: {
                if(this.text !== "") {
                    bSupportsBacklightControl = false
                }
            }
        }
    }

    Process {
        id: sendProcess
        running: false
    }
}
