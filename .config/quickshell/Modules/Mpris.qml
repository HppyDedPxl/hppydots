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
        Rectangle {
            height: parent.height
            width: parent.width
            color:'transparent'
            radius:AppearanceProvider.rounding
            // callbacks for fade timing aniamted with behavior further down
            property var onPopupStartOpen:()=>{
                iconRect.opacity = 0
            }
            property var onPopupOpened:()=>{
                iconRect.visible = false
            }
            property var onPopupClosed: ()=>{
                iconRect.visible = true
                iconRect.opacity = 1
            }
            WrapperMouseArea{
                visible: baseModule.orientation % 2
                width: 35
                y:-5
                height: width
                Rectangle {
                    id: iconRect
                    visible: true
                    color : AppearanceProvider.backgroundColorSecondary
                    width: parent.width         
                    height: parent.width
                    radius:parent.width/2
                    clip:true
                    Rectangle {
                        id: innerRect
                        visible: true
                        color : AppearanceProvider.backgroundColorSecondary
                        anchors.centerIn:parent
                        width: parent.width-10
                        y:-5
                        height: width
                        radius:width/2
                        Image {
                            anchors.fill:parent
                            source: Quickshell.iconPath(DesktopEntries.heuristicLookup(MprisHandler.getPrimaryPlayer().identity).icon)
                        }
                    }

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 150
                        }
                    }      
                }
                cursorShape: Qt.PointingHandCursor
                onClicked:{
                    baseModule.openPopup()
                }
            }
        }
    }

    Component {
        id: _popupContent

        Rectangle {
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
                            anchors.centerIn : parent
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
                        anchors.topMargin:10
                        anchors.rightMargin:0
                        height:childrenRect.height
                        StyledText {
                            anchors.centerIn : parent
                            text: base.player.trackTitle
                            color: AppearanceProvider.textColorSecondary
                            wrapMode: Text.Wrap
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignHCenter
                            width:parent.width
                        }
                    }
                    Item {
                        id: trackArtist
                        anchors.top:trackTitle.bottom
                        anchors.left:parent.left
                        anchors.right:parent.right
                        anchors.topMargin:20
                        anchors.rightMargin:0
                     
                        StyledText {
                            anchors.centerIn : parent
                            text: base.player.trackArtist
                            color: AppearanceProvider.textColorSecondary
                            wrapMode: Text.Wrap
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignHCenter
                            width:parent.width
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