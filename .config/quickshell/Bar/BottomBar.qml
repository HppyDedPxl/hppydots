import QtQuick
import QtQuick.Effects
import Quickshell
import QtQuick.Shapes
import QtQuick.Layouts
import "../Appearance"
PanelWindow {
    id: bottomBar
    property list<Item> content
    property var overlayDecorator

    screen: scope.modelData
    implicitHeight: AppearanceProvider.bottomBarWidth + AppearanceProvider.bottomBarPadding
    color: 'transparent'
    exclusiveZone: AppearanceProvider.bottomBarWidth

    anchors {
        right: true
        bottom: true
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
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.topMargin: AppearanceProvider.bottomBarPadding
        radius: 0
        offset.x: AppearanceProvider.shadowOffsetX
        offset.y: AppearanceProvider.shadowOffsetY
        blur: AppearanceProvider.shadowBlur
        spread: AppearanceProvider.shadowSpread
        color: AppearanceProvider.shadowColor
    }


    StyledCurveConnector{
        id: shapeL
        x:0
        y:AppearanceProvider.bottomBarPadding-AppearanceProvider.bottomBarAdornmentSize
        size: AppearanceProvider.topBarAdornmentSize
        rotation:180
    }

    StyledCurveConnector{
        id: shapeR
        x:parent.width - AppearanceProvider.bottomBarAdornmentSize
        y:AppearanceProvider.bottomBarPadding-AppearanceProvider.bottomBarAdornmentSize
        size: AppearanceProvider.topBarAdornmentSize
        explicitColor: AppearanceProvider.backgroundColor
        rotation:90
    }


    Rectangle{
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.topMargin: AppearanceProvider.bottomBarPadding
        color: AppearanceProvider.backgroundColorSecondary
        height:AppearanceProvider.bottomBarWidth
        clip:true

        children:[
            Loader {
                id: loader
                
                x:0
                y:-screen.height+AppearanceProvider.bottomBarWidth
                active : true
                sourceComponent: overlayDecorator  
            },
            RowLayout {
                id: barWidgets
                anchors.fill: parent
                spacing: 1
                children: bottomBar.content         
            }
        ]        
    }
}