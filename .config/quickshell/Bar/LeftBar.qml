import "../Appearance"
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell

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
