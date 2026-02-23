import "../Appearance"
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import "../Widgets"

PanelWindow {
    id: bar
    property list<Item> content
    property var overlayDecorator : null
    property var barWidth : 0
    property var barPadding : 0
    property var orientation : 0
    property var withAdornments : false
    property var adornmentSize : 0
    property var leftDecoratorColor: AppearanceProvider.backgroundColorSecondary
    property var rightDecoratorColor: AppearanceProvider.backgroundColorSecondary
    property var debug : false
    screen: scope.modelData

    implicitHeight: barWidth + barPadding
    implicitWidth: barWidth + barPadding

    color: debug?'magenta':'transparent'
    exclusiveZone: barWidth
    mask : Region {regions: {barWidgets.children.map(x=>x.region)}}

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

    MultiEffect {
        id: shadowEffect

        source: shapeL
        anchors.fill: shapeL
        shadowBlur: 1
        shadowEnabled: true
        shadowColor: AppearanceProvider.shadowColor
        shadowScale: 1
        shadowVerticalOffset: 3
        shadowHorizontalOffset: 3
        visible: true
        rotation: shapeL.rotation
    }

    MultiEffect {
        id: shadowEffect2

        source: shapeR
        anchors.fill: shapeR
        shadowBlur: 1
        shadowEnabled: true
        shadowColor: AppearanceProvider.shadowColor
        shadowScale: 1
        shadowVerticalOffset: 3
        shadowHorizontalOffset: -3
        visible: true
        rotation: shapeR.rotation
    }

    RectangularShadow {
        anchors.fill:baseRect
        radius: 0
        offset.x: AppearanceProvider.shadowOffsetX
        offset.y: AppearanceProvider.shadowOffsetY
        blur: AppearanceProvider.shadowBlur
        spread: AppearanceProvider.shadowSpread
        color: AppearanceProvider.shadowColor
    }

    StyledCurveConnector{
        id: shapeL
        visible:withAdornments
        x:adornmentPositionPresetL[bar.orientation][0]
        y:adornmentPositionPresetL[bar.orientation][1]
        size: adornmentSize
        explicitColor: leftDecoratorColor
        rotation:adornmentRotationL[bar.orientation]
        Rectangle{
            visible:withAdornments
            color:bar.debug?'red':'transparent'
            anchors.fill:parent
            opacity:0.3
        }
    }

    StyledCurveConnector{
        id: shapeR
        visible: withAdornments
        x:adornmentPositionPresetR[bar.orientation][0]
        y:adornmentPositionPresetR[bar.orientation][1]
        size: adornmentSize
        explicitColor: rightDecoratorColor
        rotation:adornmentRotationR[bar.orientation]
        Rectangle{
            visible:withAdornments
            color:bar.debug?'red':'transparent'
            anchors.fill:parent
            opacity:0.3
        }
    }

    Rectangle {
        id: baseRect

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        anchors.topMargin: paddingPresets[bar.orientation][0]
        anchors.rightMargin: paddingPresets[bar.orientation][1]
        anchors.bottomMargin: paddingPresets[bar.orientation][2]
        anchors.leftMargin: paddingPresets[bar.orientation][3]

        width: parent.width
        height: barWidth
        
        color: AppearanceProvider.backgroundColorSecondary
        clip:true
        children: [
            Loader {
                id: loader
                x:decorationLoaderXPreset[bar.orientation]
                y:decorationLoaderYPreset[bar.orientation]
                active: true
                sourceComponent: overlayDecorator
            }
        ]
    }

    Rectangle {
        id: contentRect
        property var screen: bar.screen
        property var orientation : bar.orientation
        anchors.fill: baseRect
        width: baseRect.width
        height: baseRect.height
        color: 'transparent'
        FlexboxLayout {
            id: barWidgets
            anchors.fill:parent
            direction:bar.orientation % 2 == 0 ? FlexboxLayout.Row : FlexboxLayout.Column
            alignItems: FlexboxLayout.AlignCenter
            children: bar.content
            gap:2
        }     
    }
}
