import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland

import "./"
import "../Services"
import "../Appearance"

BaseModule {
    id:baseModule
    dbgName: "mprisModule"
    content: _content
    popupContent: _popupContent
    visible: MprisHandler.getPrimaryPlayer() != null
    Component {
        id: _content
        StyledSidebarDock {
            content: Rectangle {
                id: innerRect
                visible: true
                color : 'transparent'
                anchors.centerIn:parent
                width: parent.width-10
                height: width
                radius:width/2
                clip: true
                Image {
                    anchors.fill:parent
                    source: Quickshell.iconPath(DesktopEntries.heuristicLookup(MprisHandler.getPrimaryPlayer().identity).icon)
                }
            }            
        }
    }

    Component {
        id: _popupContent

        Rectangle {
            function getAudioIcon(volume) {
                if (volume > .7)
                    return "";
                if (volume > .3)
                    return "";
                return "";
            }

            id: base
            height: 600
            width: 300
            color:'transparent'
            property var player : MprisHandler.getPrimaryPlayer()
            property var onOpen : ()=>{
                loader.item.seekBar.updateTime()
            }

            Loader {
                id: loader
                active : player != null
                sourceComponent: Rectangle {
                    id: root
                    height: base.height
                    width: base.width
                    property var seekBar : _seekBar
                    color:'transparent'
                    RowLayout {
                        id: heading
                        anchors.top:parent.top
                        anchors.left:parent.left
                        anchors.right:parent.right
                        anchors.topMargin:10
                        anchors.leftMargin:30
                        anchors.rightMargin:30
                        height:40
                        StyledButton {
                            visible:MprisHandler.hasPreviousPlayer();
                            Layout.preferredWidth:20
                            Layout.preferredHeight:20
                            color: 'transparent'
                            textColor: AppearanceProvider.textColorSecondary
                            text : ""
                            fontSize:18
                            radius: 20
                            onClick:()=>{
                                MprisHandler.previousPlayer();
                            }     
                        }
                        StyledText {
                            Layout.fillWidth:true
                            horizontalAlignment: Text.AlignHCenter
                            text: base.player.identity
                            color: AppearanceProvider.textColorSecondary
                            font.pointSize:15
                        }
                        StyledButton {
                                visible:MprisHandler.hasNextPlayer();
                                Layout.preferredWidth:20
                                Layout.preferredHeight:20
                                color: 'transparent'
                                textColor: AppearanceProvider.textColorSecondary
                                text : ""
                                fontSize:18
                                radius: 20
                                onClick:()=>{
                                    MprisHandler.nextPlayer();
                                }
                                
                            }
                    }
                    Image {
                        id:albumArt
                        anchors.top: heading.bottom
                        anchors.left:parent.left
                        anchors.right:parent.right
                        anchors.topMargin:5
                        anchors.leftMargin:40
                        anchors.rightMargin:40
                        fillMode: Image.PreserveAspectFit
                        source: player.trackArtUrl
                    }
                    Item {
                        id: trackTitle
                        anchors.top:albumArt.bottom
                        anchors.left:parent.left
                        anchors.right:parent.right
                        anchors.topMargin:20
                        anchors.rightMargin:0
                        height: 8
                        StyledText {
                            anchors.centerIn : parent
                            text: base.player.trackTitle
                            color: AppearanceProvider.textColorSecondary
                            wrapMode: Text.Wrap
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignHCenter
                            width:parent.width
                            maximumLineCount:1
                        }
                    }
                    Item {
                        id: trackArtist
                        anchors.top:trackTitle.bottom
                        anchors.left:parent.left
                        anchors.right:parent.right
                        anchors.topMargin:20
                        anchors.rightMargin:0
                        height:8
                        StyledText {
                            anchors.centerIn : parent
                            text: base.player.trackArtist
                            color: AppearanceProvider.textColorSecondary
                            wrapMode: Text.Wrap
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignHCenter
                            width:parent.width
                            maximumLineCount:1
                        }
                    }
                    Rectangle {
                        id: controls
                        anchors.top:trackArtist.bottom
                        anchors.left:parent.left
                        anchors.right:parent.right
                        anchors.topMargin:40
                        anchors.rightMargin:40
                        anchors.leftMargin:40
                        height:controls.width/4
                        color:'transparent'
                        RowLayout{
                            anchors.fill:controls
                            uniformCellSizes:true
                            StyledButton {
                                Layout.preferredWidth:controls.width/4
                                Layout.preferredHeight:controls.width/4
                                width:undefined
                                border.width: 3
                                border.color: AppearanceProvider.textColorSecondary
                                color: AppearanceProvider.accentColor
                                textColor: AppearanceProvider.textColorSecondary
                                text : ""
                                fontSize:30
                                radius: controls.width/4
                                onClick:()=>{
                                    player.previous()
                                }
                                
                            }
                            StyledButton {
                                Layout.preferredWidth:controls.width/4
                                Layout.preferredHeight:controls.width/4
                                width:undefined
                                border.width: 3
                                border.color: AppearanceProvider.textColorSecondary
                                color: AppearanceProvider.accentColor
                                textColor: AppearanceProvider.textColorSecondary
                                text : player.isPlaying ? "" : ""
                                fontSize:30
                                radius: controls.width/4
                                onClick:()=>{
                                    if(player.isPlaying) 
                                        player.pause(); 
                                    else 
                                        player.play();
                                }

                            }
                            StyledButton {
                                Layout.preferredWidth:controls.width/4
                                Layout.preferredHeight:controls.width/4
                                width:undefined
                                border.width: 3
                                border.color: AppearanceProvider.textColorSecondary
                                color: AppearanceProvider.accentColor
                                textColor: AppearanceProvider.textColorSecondary
                                text : ""
                                fontSize:30
                                radius: controls.width/4
                                onClick:()=>{
                                    player.next()
                                }
                            }
                        }
                    }  
                    RowLayout {
                        id: seekBar
                        anchors.top:controls.bottom
                        anchors.left:parent.left
                        anchors.right:parent.right
                        anchors.topMargin:20
                        anchors.rightMargin:40
                        anchors.leftMargin:40
                        height:30
                        StyledSeekBar {
                            id: _seekBar
                            Layout.fillWidth:true
                            height:parent.height
                            target: player
                        }
                    }
                    RowLayout {
                        id: timingBar
                        anchors.top:seekBar.bottom
                        anchors.left:parent.left
                        anchors.right:parent.right
                        anchors.topMargin:0
                        anchors.rightMargin:40
                        anchors.leftMargin:40
                        height:15

                        StyledText {
                            property var pos: player.position
                            Layout.preferredWidth:50
                            Layout.fillHeight:true
                            text: _seekBar.getTimeElapsedString()
                            color:AppearanceProvider.textColorSecondary
                        }
                        Rectangle {
                            Layout.fillWidth:true
                        }
                        StyledText {
                            Layout.preferredWidth:50
                            text: _seekBar.getTimeRemainingString()
                            color:AppearanceProvider.textColorSecondary
                        }
                    }
                    RowLayout {   
                        anchors.top:timingBar.bottom
                        anchors.left:parent.left
                        anchors.right:parent.right
                        anchors.topMargin:30
                        anchors.rightMargin:40
                        anchors.leftMargin:40
                        height:15
                        spacing:10
                        WrapperMouseArea {
                        id: audioArea
                        property var bHovered: false
                        Layout.minimumWidth: 20
                        hoverEnabled: true
                        onEntered: {
                            bHovered = true;
                        }
                        onExited: {
                            bHovered = false;
                        }
                        states: [
                            State {
                                name: "highlit"
                                when: audioArea.bHovered
                                PropertyChanges {
                                    audioIcon {
                                        color:AppearanceProvider.textColorSecondary
                                    }
                                }
                            }
                        ]
                        transitions: [
                            Transition {
                                from: ""
                                to: "highlit"
                                reversible: true
                                PropertyAnimation {
                                    property: "audioIcon.color"
                                    duration: 250
                                }
                            }
                        ]
                         
                        StyledText {
                            id: audioIcon
                            text: getAudioIcon(player.volume)
                            color:AppearanceProvider.textColorSecondary
        
                        }
                    }
                        StyledSlider {
                            id: volumeSlider
                            value: player.volume
                            Layout.fillWidth:true
                            slider.onMoved : {
                                player.volume = slider.value
                            }
                            onScrolled : x => {
                                player.volume = x
                            }
                        }
                        StyledText {
                            Layout.minimumWidth: 25
                            text: Math.floor(player.volume * 100) + "%"
                            color:AppearanceProvider.textColorSecondary
    
                        }

                    }

                    Rectangle {
                        width:40
                        height:40
                        anchors.bottom:root.bottom
                        anchors.right:root.right
                        anchors.bottomMargin:10
                        anchors.rightMargin:20
                        color:'transparent'
                        WrapperMouseArea {
                            anchors.fill:parent
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                if(base.player.identity !== "")
                                    Hyprland.dispatch("movetoworkspace " + Hyprland.focusedWorkspace.id + ",class:" + base.player.identity.toLowerCase())
                            }
                            IconImage{
                                anchors.fill:parent
                                source: Quickshell.iconPath(DesktopEntries.heuristicLookup(base.player.identity).icon)
                            }
                        }
                    }
  
                }
            }
        }
    }
}