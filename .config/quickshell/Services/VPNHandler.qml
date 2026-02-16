pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Polkit

Singleton {
    id: vpnHandler

    function initService() {
        loadWireguardConfs()
    }

    ScriptModel {
        id: vpnConfigNames
    }

    property string vpnConfigPath: "/etc/wireguard"
    property string connectedInterface: ""


    function getVPNConfigs(){
        return vpnConfigNames;
    }

    function loadWireguardConfs () {
        getWgConfs.running = true
        getConnectedInterface.running = true
    }

    function isConnected () {
        return connectedInterface !== ""
    }

    function connectToInterface (interfaceName) {
        noOutputProc.command = ["pkexec","wg-quick","up",interfaceName]
        noOutputProc.running = true
    }

    function disconnect (){
        noOutputProc.command = ["pkexec","wg-quick","down",connectedInterface]
        noOutputProc.running = true
    }

    Process {
        id: noOutputProc 
        signal finished()
        stdout: StdioCollector {
            onStreamFinished:{
                loadWireguardConfs()
            }
        }
    }

    Process {
        id:getWgConfs
        command: ["pkexec","ls","/etc/wireguard"]
        stdout: StdioCollector {
            onStreamFinished: {
                if(this.text !== ""){ 
                    vpnConfigNames.values = []
                    var result = this.text.split('\n')
                    for(let i = 0; i < result.length; i++){
                        if (result[i].endsWith('.conf')){
                            vpnConfigNames.values.push(result[i].substring(0,result[i].length - 5))
                        }
                    }
                }    
            }
        }
        stderr: StdioCollector {
            onStreamFinished: {
                if(this.text !== "")
                    console.log("error! " + this.text)
            }
        }
    }

    Process {
        id: getConnectedInterface
        command: ["pkexec","wg","show"]
        stdout: StdioCollector {
            onStreamFinished: {
                if(this.text !== "") { 
                    connectedInterface = this.text.split("interface: ").pop().split('\n')[0]
                } else {
                    connectedInterface = ""
                }
            }
        }
        stderr: StdioCollector {
            onStreamFinished: {
                if(this.text !== ""){
                    connectedInterface = ""
                    console.log("error! " + this.text)
                }
            }
        }
    }
}