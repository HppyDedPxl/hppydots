import QtQuick
import QtQuick.Layouts
import Quickshell
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
            color:'red'
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

            Loader {
                active : player != null
                sourceComponent: Rectangle {
                    id: root
                    height: base.height
                    width: base.width
                    color:'transparent'
                    Item {
                        id: heading
                        anchors.top:parent.top
                        anchors.left:parent.left
                        anchors.right:parent.right
                        anchors.topMargin:10
                        anchors.rightMargin:0
                        height:40
                        StyledText {
                            anchors.centerIn : parent
                            text: base.player.desktopEntry
                            color: AppearanceProvider.textColorSecondary
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
                        height:20
                        StyledText {
                            anchors.centerIn : parent
                            text: base.player.trackTitle
                            color: AppearanceProvider.textColorSecondary
                        }
                    }
                    Item {
                        id: trackArtist
                        anchors.top:trackTitle.bottom
                        anchors.left:parent.left
                        anchors.right:parent.right
                        anchors.topMargin:10
                        anchors.rightMargin:0
                        height:20
                        StyledText {
                            anchors.centerIn : parent
                            text: base.player.trackArtist
                            color: AppearanceProvider.textColorSecondary
                        }
                    }
                    Rectangle {
                        id: controls
                        anchors.top:trackArtist.bottom
                        anchors.left:parent.left
                        anchors.right:parent.right
                        anchors.topMargin:20
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

                    Rectangle {
                        id: seekBar
                        anchors.top:controls.bottom
                        anchors.left:parent.left
                        anchors.right:parent.right
                        anchors.topMargin:20
                        anchors.rightMargin:40
                        anchors.leftMargin:40
                        height:30
                        color:'transparent'

                        StyledSeekBar {
                            width:seekBar.width
                            height:seekBar.height
                            target: player
                        }
                    }   
                }
            }
        }
    }
}