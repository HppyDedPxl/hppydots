import "../Appearance"
import "./"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

BaseModule {
    id: baseModule
    width: 150

    property var audioSink: Pipewire.defaultAudioSink
    property int volume: (audioSink && audioSink.audio) ? Math.round(audioSink.audio.volume * 100) : 0
    property bool muted: audioSink && audioSink.audio ? audioSink.audio.muted : false
    property var audioSource: Pipewire.defaultAudioSource
    property int sensitivity: (audioSource && audioSource.audio) ? Math.round(audioSource.audio.volume * 100) : 0
    property bool micMuted: audioSource && audioSource.audio ? audioSource.audio.muted : false
    property var curVolumeIcon: getAudioIcon()

    function getAudioIcon() {
        if (muted)
            return "";

        if (volume > 70)
            return "";

        if (volume > 30)
            return "";

        return "";
    }

    function getMicIcon() {
        if (!micMuted)
            return "";

        return "";
    }

    content: _baseContent
    popupContent: _popupContent
    dbgName: "AudioModule"
    bHasClickAction: true
    onClickExecCommand: ["pavucontrol"]

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    Component {
        id: _baseContent

        Rectangle {
            height: parent.height
            width: height
            color: 'transparent'

            StyledText {
                anchors.centerIn: parent
                color: baseModule.textColorOnBar
                text: volume + "% " + getAudioIcon() + "  " + sensitivity + "% " + getMicIcon()
            }

        }

    }

    Component {
        id: _popupContent

        Rectangle {
            id: wrapper

            width: 300
            height: 100
            color: 'transparent'

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 5

                        WrapperMouseArea {
                        id: audioArea
                        property var bHovered: false
                        Layout.minimumWidth: 30
                        hoverEnabled: true
                        onEntered: {
                            bHovered = true;
                        }
                        onExited: {
                            bHovered = false;
                        }
                        onClicked: {
                            audioSink.audio.muted = !audioSink.audio.muted;
                        }
                        states: [
                            State {
                                name: "highlit"
                                when: audioArea.bHovered
                                PropertyChanges {
                                    audioIcon {
                                        color: AppearanceProvider.highlightColor
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
                            text: getAudioIcon()
                        }
                    }

                    StyledSlider {
                        id: volumeSlider

                        Layout.fillWidth: true
                        value: audioSink.audio.volume
                        slider.onMoved: {
                            audioSink.audio.volume = slider.value;
                        }
                        onScrolled: x =>{
                            audioSink.audio.volume = x;
                        }
                    }

                    StyledText {
                        Layout.minimumWidth: 30
                        text: volume + "%"
                    }

                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 5

                    WrapperMouseArea {
                        id: micArea
                        property var bHovered: false
                        Layout.minimumWidth: 30
                        hoverEnabled: true
                        onEntered: {
                            bHovered = true;
                        }
                        onExited: {
                            bHovered = false;
                        }
                        onClicked: {
                            audioSource.audio.muted = !audioSource.audio.muted;
                        }
                        states: [
                            State {
                                name: "highlit"
                                when: micArea.bHovered
                                PropertyChanges {
                                    micIcon {
                                        color: AppearanceProvider.highlightColor
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
                                    property: "micIcon.color"
                                    duration: 250
                                }
                            }
                        ]
                        StyledText {
                            id: micIcon
                            text: getMicIcon()
                        }
                    }

                    StyledSlider {
                        id: micSlider
                        Layout.fillWidth: true
                        value: audioSource.audio.volume
                        slider.onMoved: {
                            audioSource.audio.volume = slider.value;
                        }
                        onScrolled: x =>{
                            audioSource.audio.volume = x;
                        }
                        to: 1.5
                    }
                    StyledText {
                        Layout.minimumWidth: 30
                        text: sensitivity + "%"
                    }

                }

            }

        }

    }

}
