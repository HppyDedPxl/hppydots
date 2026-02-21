import "../Appearance"
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import "../Widgets"

PanelWindow {
    id: leftBar

    property list<Item> content
    property var overlayDecorator

    screen: scope.modelData
    implicitWidth: AppearanceProvider.leftBarWidth + AppearanceProvider.leftBarPadding
    color: 'transparent'
    exclusiveZone: AppearanceProvider.leftBarWidth

    anchors {
        top: true
        bottom: true
        left: true
    }

    RectangularShadow {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: AppearanceProvider.leftBarPadding
        radius: 0
        offset.x: AppearanceProvider.shadowOffsetX
        offset.y: AppearanceProvider.shadowOffsetY
        blur: AppearanceProvider.shadowBlur
        spread: AppearanceProvider.shadowSpread
        color: AppearanceProvider.shadowColor
    }

    Rectangle {
        id: baseRect

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: AppearanceProvider.leftBarPadding
        color: AppearanceProvider.backgroundColorSecondary
        clip:true
        children: [
            Loader {
                id: loader

                active: true
                sourceComponent: overlayDecorator
            }
        ]
    }
          Rectangle {
          id:rect
          x:-width/2+height/2+AppearanceProvider.leftBarWidth
          y:width/2+AppearanceProvider.rounding*2
          height:AppearanceProvider.leftBarPadding
          width:screen.height-AppearanceProvider.topBarWidth-AppearanceProvider.bottomBarWidth-AppearanceProvider.rounding*2
          color:'transparent'
          rotation:90
          MusicViz {
            id:visualizer
            anchors.fill:parent
            color:AppearanceProvider.backgroundColorSecondary
            gradient:LinearGradient {
                orientation:Gradient.Vertical
                x1:0
                y1:0
                x2:0
                y2:visualizer.innerShape.height
                spread: ShapeGradient.RepeatSpread
                stops: [
                    GradientStop{
                   
                    position: 1
                    color: AppearanceProvider.backgroundColorSecondary
                }
                ]         
            }
          }
      }

    Rectangle {
        id: contentRect
        property var screen: leftBar.screen
        anchors.fill: baseRect
        color: 'transparent'
        ColumnLayout {
            id: barWidgets

            anchors.fill: parent
            spacing: 1
            children: leftBar.content

            Rectangle {
                anchors.fill: parent
                color: 'red'
            }
        }
    }

}
