import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick.Shapes
import QtQuick.Effects
import "./"
import "../Services"
import "../Appearance"
import "../Widgets"
Rectangle {
    id: root
    property var seekBar : _seekBar
    property var player : null
    color:'transparent'
    property var buttonSize: 40
    property var bShowVolumeSlider : true
    property var bShowVisualizationButton : true
    property var bShowPlayerIcon : true
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
            border.width:0
            fontSize:18
            radius: 20
            onClick:()=>{
                MprisHandler.previousPlayer();
            }     
        }
        StyledText {
            Layout.fillWidth:true
            horizontalAlignment: Text.AlignHCenter
            text: root.player.identity
            color: AppearanceProvider.textColorSecondary
            font.pointSize:15
        }
        StyledButton {
            visible:MprisHandler.hasNextPlayer();
            Layout.preferredWidth:20
            Layout.preferredHeight:20
            border.width:0
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
        anchors.leftMargin:50
        anchors.rightMargin:50
        fillMode: Image.PreserveAspectFit
        source: player.trackArtUrl
    }
    Item {
        id: trackTitle
        anchors.top:albumArt.bottom
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.topMargin:30
        anchors.rightMargin:10
        anchors.leftMargin:10
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
        anchors.topMargin:15
        anchors.rightMargin:70
        anchors.leftMargin:70
        height:controls.width/4
        color:'transparent'
        RowLayout{
            anchors.fill:controls
            uniformCellSizes:true
            StyledButton {
                Layout.preferredWidth:controls.width/4
                Layout.preferredHeight:controls.width/4
                width:undefined
                text : ""
                fontSize: 20
                radius: controls.width/4
                onClick:()=>{
                    player.previous()
                }
                
            }
            StyledButton {
                Layout.preferredWidth:controls.width/4
                Layout.preferredHeight:controls.width/4
                width:undefined
                text : player.isPlaying ? "" : ""
                fontSize:20
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
                text : ""
                fontSize:20
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
        anchors.topMargin:10
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
        anchors.rightMargin:45
        anchors.leftMargin:45
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
        anchors.rightMargin:45
        anchors.leftMargin:45
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
            visible: root.bShowVolumeSlider
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
            visible: root.bShowVolumeSlider
            Layout.minimumWidth: 25
            text: Math.floor(player.volume * 100) + "%"
            color:AppearanceProvider.textColorSecondary

        }

    }
    StyledButton {
        width:40
        height:40
        visible: root.bShowVisualizationButton
        anchors.bottom:root.bottom
        anchors.right:root.right
        anchors.bottomMargin:10
        anchors.rightMargin:70
        color:'transparent'
        opacity: CavaListener.isListening() ? 1 : 0.25
        text: '󰺢'
        buttonPrimaryColor:AppearanceProvider.textColorSecondary
        border.width:0
        fontSize:23

        onClick:()=>{
            if(CavaListener.isListening())
                CavaListener.stopListening()
            else
                CavaListener.startListening()
        }
    }
    Rectangle {
        visible: root.bShowPlayerIcon
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
