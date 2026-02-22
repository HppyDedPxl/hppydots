import QtQuick
import QtQuick.Effects
import Quickshell
import QtQuick.Layouts
import "../Appearance"
import "../Widgets"
import QtQuick.Shapes
PanelWindow {
    id: rightBar
    property list<Item> content
    property var overlayDecorator

    screen: scope.modelData
    implicitWidth: AppearanceProvider.rightBarWidth + AppearanceProvider.rightBarPadding
    color: 'transparent'
    exclusiveZone: AppearanceProvider.rightBarWidth
    mask: Region {item: contentRect}

    anchors {
        top: true
        bottom: true
        right: true
    }

    RectangularShadow {
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.leftMargin: AppearanceProvider.rightBarPadding
        radius: 0
        offset.x: AppearanceProvider.shadowOffsetX
        offset.y: AppearanceProvider.shadowOffsetY
        blur: AppearanceProvider.shadowBlur
        spread: AppearanceProvider.shadowSpread
        color: AppearanceProvider.shadowColor
    }

    Rectangle{
        id:baseRect
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.leftMargin: AppearanceProvider.rightBarPadding
       color: AppearanceProvider.backgroundColorSecondary
       clip:true
       children: [
            Loader {
                id: loader
                x: -screen.width+AppearanceProvider.rightBarWidth
                y: 0
                active: true
                sourceComponent: overlayDecorator
            }
        ]
    }

    // Rectangle {
    //       id:rect
    //       x:-width/2+height/2
    //       y:width/2
    //       height:AppearanceProvider.rightBarPadding
    //       width:screen.height
    //       color:'red'
    //       rotation:-90
    //       MusicViz {
    //         id:visualizer
    //         anchors.fill:parent
    //         color:AppearanceProvider.backgroundColorSecondary
    //         beginPadding:AppearanceProvider.rounding*2 + AppearanceProvider.bottomBarWidth
    //         endPadding:AppearanceProvider.rounding*2
    //         gradient:LinearGradient {
    //             orientation:Gradient.Vertical
    //             x1:0
    //             y1:0
    //             x2:visualizer.innerShape.width
    //             y2:0
    //             //spread: ShapeGradient.RepeatSpread
    //             stops: [
    //                 GradientStop{
    //                     position: 1
    //                     color: AppearanceProvider.backgroundColorSecondary
    //                     },
    //                     GradientStop{
    //                     position:{console.log((modelData.height/1.3)/modelData.height); return   1-((modelData.height/1.3)/modelData.height) + 0.0000001}
    //                     color:AppearanceProvider.backgroundColorSecondary
                        
    //                 },
    //                 GradientStop{
    //                     position:1-((modelData.height/1.3)/modelData.height)
    //                     color:AppearanceProvider.highlightColor
    //                 },
    //                 GradientStop{
    //                     position:0
    //                     color:AppearanceProvider.highlightColor
    //                 },
    //                 // GradientStop{
    //                 //     position:0.20001
    //                 //     color:AppearanceProvider.highlightColor
    //                 // },
    //                 // GradientStop{
    //                 //     position:0.2
    //                 //     color:AppearanceProvider.accentColor
    //                 // },
    //                 // GradientStop{
    //                 //     position: 0.10000001
    //                 //     color:AppearanceProvider.accentColor
    //                 // },
    //                 // GradientStop{
    //                 //     position: 0.1
    //                 //     color:AppearanceProvider.backgroundColor
    //                 // },
    //                 // GradientStop{
    //                 //     position:0.0
    //                 //     color:AppearanceProvider.backgroundColor
    //                 // }
    //             ]         
    //         }
    //       }
    //   }

    Rectangle {
        id: contentRect

        property var screen: rightBar.screen

        anchors.fill: baseRect
        color: 'transparent'

        ColumnLayout {
            id: barWidgets
            anchors.fill: parent
            spacing: 1
            children: rightBar.content

        }

    }
}