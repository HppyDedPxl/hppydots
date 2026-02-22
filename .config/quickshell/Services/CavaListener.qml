pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import "./"

Singleton {
    id: cavaListener
    readonly property var bucketAmount:16
    property list<double> audioData:[bucketAmount]
    readonly property var valueRange:1000
    function startListening() {
        cavaProc.running=true;
    }
    function stopListening() {
        cavaProc.running=false;
        audioData=[bucketAmount]
    }
    function isListening(){
        return cavaProc.running;
    }

    Process {
        id: cavaProc
        running: true
        command: ["sh","-c",
`cava -p /dev/stdin <<EOF
[general]
bars = ${bucketAmount}
framerate = 15
autosens = 1
[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = ${valueRange}
bar_delimiter = 59
[smoothing]
monstercat = 1.5
waves = 0
gravity = 100
noise_reduction = 0.20
EOF`]

        stdout: SplitParser {
            onRead: (output)=>{
                audioData = output.split(';').map(val => parseFloat(val.trim())).filter(val => !isNaN(val));
            }
        }
    }
}