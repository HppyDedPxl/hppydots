import "../Appearance"
import "../Modules"
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell

PanelWindow {
    id: topBar
    property list<Item> content
    property var overlayDecorator: null
    screen: scope.modelData
    implicitHeight: AppearanceProvider.topBarWidth + AppearanceProvider.topBarPadding
    color: 'transparent'
    exclusiveZone: AppearanceProvider.topBarWidth

    anchors {
        top: true
        right: true
        left: true
    }

    MultiEffect {
        id: shadowEffect
        source: shapeL
        anchors.fill: shapeL
        shadowBlur: 1
        shadowEnabled: true
        shadowColor: AppearanceProvider.shadowColor
        shadowScale: 1
        shadowVerticalOffset: 0
        shadowHorizontalOffset: 0
        visible: true
        rotation:shapeL.rotation
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
    }

    RectangularShadow {
        anchors.fill: topBarGeometry
        offset.x: AppearanceProvider.shadowOffsetX
        offset.y: AppearanceProvider.shadowOffsetY
        radius: 0
        blur: AppearanceProvider.shadowBlur
        spread: AppearanceProvider.shadowSpread
        color: AppearanceProvider.shadowColor
    }

    Rectangle {
        id: topBarGeometry
        width: parent.width
        height: AppearanceProvider.topBarWidth
        clip: true

        color:AppearanceProvider.backgroundColorSecondary
        children:[
            Loader {
                id: loader
                active : true
                sourceComponent: overlayDecorator  
            },
            RowLayout {
                id: barWidgets
                anchors.fill: parent
                spacing: 1
                children: topBar.content         
            }
        ]

    }

    StyledCurveConnector{
        id: shapeL
        x:0
        y:AppearanceProvider.topBarWidth
        size: AppearanceProvider.topBarAdornmentSize
        rotation:270
    }

    StyledCurveConnector{
        id: shapeR
        x:parent.width - AppearanceProvider.topBarAdornmentSize
        y:AppearanceProvider.topBarWidth
        size: AppearanceProvider.topBarAdornmentSize
        rotation:0
    }

    mask: Region {
        item: {
            topBarGeometry;
        }
    }

}
