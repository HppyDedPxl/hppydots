import "../Appearance"
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import "../Widgets"
import "../Services"
import QtQuick.Controls

PanelWindow {
    
    id: bar
    property list<Item> contentLeft : []
    property list<Item> content : []
    property list<Item> contentRight : []
    property var overlayDecorator : null
    property var barWidth : 0
    property var barPadding : 0
    property var orientation : 0
    property var withAdornments : false
    property var adornmentSize : 0
    property var leftDecoratorColor: AppearanceProvider.backgroundColorSecondary
    property var rightDecoratorColor: AppearanceProvider.backgroundColorSecondary
    property var debug : false
    property var hiddenContentSize: 450
    screen: scope.modelData
                    property var bFixedAttachmentPoint : [baseRect.x+baseRect.width/2,baseRect.height-baseRect.yOffset]

    property var bOpen : false

    implicitHeight: barWidth + barPadding + hiddenContentSize
    implicitWidth: barWidth + barPadding + hiddenContentSize

    color: debug?'magenta':'transparent'
    exclusiveZone: barWidth
    //mask : Region {regions: {barWidgets.children.map(x=>x.region)}}
    mask: Region{item: baseRect}
    readonly property var anchorPresets : [
        [true,true,false,true],
        [true,true,true,false],
        [false,true,true,true],
        [true,false,true,true],
    ];
    readonly property var paddingPresets : [
            [0,0,barPadding,0],
            [0,0,0,barPadding],
            [barPadding,0,0,0],
            [0,barPadding,0,0],
    ];

    readonly property var adornmentRotationL: [270,90,180,270]
    readonly property var adornmentRotationR: [0,0,90,180]

    readonly property var adornmentPositionPresetL : [
        [0,barWidth],
        [bar.width-barWidth-adornmentSize,bar.height-adornmentSize],
        [0,barPadding - adornmentSize],
        [barWidth,0]
    ]
    readonly property var adornmentPositionPresetR : [
        [bar.width - adornmentSize,barWidth],
        [bar.width-barWidth-adornmentSize,0],
        [bar.width - adornmentSize, barPadding - adornmentSize ],
        [barWidth,bar.height-adornmentSize]
    ]

    readonly property var decorationLoaderXPreset: [0,-screen.width+barWidth,0,0]
    readonly property var decorationLoaderYPreset: [0,0,-screen.height+barWidth,0]

    anchors {
        top: anchorPresets[bar.orientation][0]
        right:anchorPresets[bar.orientation][1]
        bottom: anchorPresets[bar.orientation][2]
        left: anchorPresets[bar.orientation][3]
    }


    StyledCurveConnector{
        id: shapeLL
        visible:withAdornments

        anchors.horizontalCenter : baseRect.left
        anchors.horizontalCenterOffset : -barWidth / 2 + 2
        size: barWidth
        explicitColor: AppearanceProvider.nativeBackgroundColor
        rotation:1
        Rectangle{
            visible:withAdornments
            color:"transparent"//bar.debug?'red':'transparent'
            anchors.fill:parent
            opacity:0.3
        }
    }
   

    StyledCurveConnector{
        id: shapeRR
        visible:withAdornments
        // x:adornmentPositionPresetL[bar.orientation][0]
        // y:adornmentPositionPresetL[bar.orientation][1]

        anchors.horizontalCenter : baseRect.right
        anchors.horizontalCenterOffset : barWidth / 2 - 2
        size: barWidth 
        explicitColor: AppearanceProvider.nativeBackgroundColor
        rotation:270
        Rectangle{
            visible:withAdornments
            color:"transparent"//bar.debug?'red':'transparent'
            anchors.fill:parent
            opacity:0.3
        }
    }

    Rectangle {
        id: baseRect
        property var yOffset : bar.hiddenContentSize-10
        y: 0 - yOffset
        anchors.horizontalCenter : parent.horizontalCenter
        bottomLeftRadius: 25
        bottomRightRadius: 25
        width: 800
        anchors.topMargin: paddingPresets[bar.orientation][0]
        anchors.rightMargin: paddingPresets[bar.orientation][1]
        anchors.bottomMargin: paddingPresets[bar.orientation][2]
        anchors.leftMargin: paddingPresets[bar.orientation][3]
        height: barWidth + hiddenContentSize
        color: AppearanceProvider.nativeBackgroundColor
        clip:true


        states: [
            State {
                name: "open"
                when : bar.bOpen == true
                PropertyChanges {
                    baseRect {
                        yOffset : 0
                    }
                }
            },
            State {
                name : "closed"
                when: bar.bOpen == false
            }
        ]

        transitions : [
            Transition {
                from: "closed"
                to:  "open"
                reversible: true
                NumberAnimation {
                    properties: "baseRect.yOffset"
                    duration: 1000
                    easing.type : Easing.InOutCubic
                }
            }
        ]
        
        ColumnLayout {
            anchors.fill : parent
            id: contentRectColumn
            Rectangle {
                id: contentRectRectangle
                Layout.fillHeight : true
                Layout.fillWidth: true
                color:"transparent"
                RowLayout {
                    anchors.fill:parent
                    // ----------- MPRIS
                    Rectangle {
                        function getAudioIcon(volume) {
                            if (volume > .7)
                                return "";
                            if (volume > .3)
                                return "";
                            return "";
                        }

                        id: base
                        Layout.fillHeight:true
                        width:300
                        color:'transparent'
                        property var player : MprisHandler.getPrimaryPlayer()
                        property var onOpen : ()=>{
                            loader.item.seekBar.updateTime()
                        }

                        Loader {
                            id: loader
                            active : true
                            sourceComponent: MprisWidget {
                                player: MprisHandler.getPrimaryPlayer()
                                height:base.height
                                width:base.width
                                bShowVolumeSlider : false
                                bShowVisualizationButton : false
                                bShowPlayerIcon : false
                            }
                        }
                    }
                    // MPRIS END -------------------------
                    Rectangle {
                        Layout.preferredWidth: 200
                    }
                    ControlCenterWidget {
                        Layout.fillHeight:true
                        Layout.fillWidth:true
                    }
                    Rectangle{
                        Layout.preferredWidth: 20
                    }

                }
            }
            RowLayout{
                id: contentRectRowLayout
                Layout.bottomMargin:6
                Rectangle {
                    id: leftContentRect
                    Layout.fillWidth:true
                    height: barWidth - 10

                    color:"transparent"
                     FlexboxLayout {
                        id: barWidgetsLeft
                        anchors.fill:parent
                        direction:bar.orientation % 2 == 0 ? FlexboxLayout.Row : FlexboxLayout.Column
                        alignItems: FlexboxLayout.AlignCenter
                        children: bar.contentLeft
                        property var targetBar : bar
                        gap:2
                    }     
                }
                Rectangle {
                    id: mainContentRect
                    property var screen: bar.screen
                    property var orientation : bar.orientation
                    property var barWidth : bar.barWidth
                    Layout.fillWidth:true
                    height: barWidth - 10
                    color: 'transparent'

                    FlexboxLayout {
                        id: barWidgets
                        anchors.fill:parent
                        direction:bar.orientation % 2 == 0 ? FlexboxLayout.Row : FlexboxLayout.Column
                        alignItems: FlexboxLayout.AlignCenter
                        property var targetBar : bar
                        children: bar.content
                        gap:2
                    }     
                }
                Rectangle{
                    id: rightContentRect
                    height: barWidth - 10
                    color: "transparent"
                    Layout.fillWidth:true
                     FlexboxLayout {
                        id: barWidgetsRight
                        anchors.fill:parent
                        direction:bar.orientation % 2 == 0 ? FlexboxLayout.Row : FlexboxLayout.Column
                        alignItems: FlexboxLayout.AlignCenter
                        property var targetBar : bar
                        children: bar.contentRight
                        gap:2
                    }     
                }
            }
           
        }
        ColumnLayout{
            height:14
            width:parent.width
            anchors.bottom: parent.bottom
            Rectangle{    
                color:"transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                MouseArea{
                    anchors.fill:parent
                    onClicked: {
                        bar.bOpen = !bar.bOpen
                    }
                    onEntered: {
                        dropButton.bHovered = true
                    }
                    onExited: {
                        dropButton.bHovered = false
                    }
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled:true
                    ColumnLayout{
                        anchors.fill:parent 
                        Rectangle {
                            id: dropButton              
                            radius:25
                            opacity: 0
                            color:"lightgray"
                            
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            Layout.leftMargin:100
                            Layout.rightMargin:100
                            Layout.topMargin:8
                            Layout.bottomMargin:3
                            
                            property var bHovered: false
                            states : [
                                State{
                                    name : "hovered"
                                    when : dropButton.bHovered
                                    PropertyChanges {
                                        dropButton {
                                            opacity : .6
                                        }
                                    }
                                },
                                State {
                                    name : "unhovered"
                                    when : !dropButton.bHovered

                                }
                            ]
                            transitions : [
                                Transition {
                                    from: "unhovered"
                                    to:  "hovered"
                                    reversible: true
                                    NumberAnimation {
                                        properties: "dropButton.opacity"
                                        duration: 250
                                        easing.type : Easing.InOutCubic
                                    }

                                }
                            ]
                        }
                    }
                }
            }
        }   
    }  
}
