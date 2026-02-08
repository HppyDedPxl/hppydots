pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell
import "./Modules"
import "./Services"
import "./Appearance"

Variants {
  model: Quickshell.screens
  
  MultiEffect {
    
  }
  Scope {
    id: scope
    required property ShellScreen modelData
    
    // My FNQRT Border Shape
    property color barsColor: AppearanceProvider.backgroundColor
    property real borderWidth: 45//18//16 
    property real cornerRadius: 20
    
    // I Start with the top border
    PanelWindow {
      id: topBar
      screen: scope.modelData
      implicitHeight: borderWidth+10

      color: 'transparent'
      anchors {
        top: true
        right: true
        left: true
      }
      RectangularShadow {
        anchors.fill:topBarGeometry
        offset.x: -10
        offset.y: -5
        radius: 0
        blur: 15
        spread: 5
        color:"black"
      }
      Rectangle{
        id: topBarGeometry
        width:parent.width
        height: borderWidth
        color: barsColor
        Row{
          anchors.fill : parent
            id : topRow
            spacing:6

            TimeModule {
              width:80
              bPopupOnHover:true
            }
          }
      }
      
      
    }
    
    // Then after that the bottom border
    PanelWindow {
      id: bottomBar
      screen: scope.modelData
      implicitHeight: borderWidth
      color: barsColor
      anchors {
        bottom: true
        right: true
        left: true
      }
    }
    
    // This is basically controlling the left border its the thing pushing the stuff inside guys     
    PanelWindow {
      id: leftBar
      screen: scope.modelData
      implicitWidth: borderWidth + 5//5
      color: "transparent"
      anchors {
        top: true
        bottom: true
        left: true
      }
      
      Rectangle {
        width: borderWidth
        height: parent.height
        color: barsColor
        anchors.left: parent.left
      }
    }
    
    // Right border (the thing pushing the stuff inside)
    PanelWindow {
      id: rightBar
      screen: scope.modelData
      implicitWidth: borderWidth + 5//5
      color: "transparent"
      anchors {
        top: true
        bottom: true
        right: true
      }
      
      Rectangle {
        width: borderWidth
        height: parent.height
        color: barsColor
        anchors.right: parent.right
      }
    }
    
    // FNQRT This is where the corner aspects begins and its essentially a visual thing not actually pushign the conet thats controlled by the stuff above if it helps youn understand how it works (Top-left corner)
    PanelWindow {
      id: topLeftCorner
      screen: scope.modelData
      implicitWidth: cornerRadius
      implicitHeight: cornerRadius
      color: "transparent"
      exclusiveZone: 0
      anchors {
        top: true
        left: true
      }
      margins.left: -5
      
      Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer
        
        ShapePath {
          strokeWidth: 0
          fillColor: barsColor
          startX: 0
          startY: cornerRadius
          PathArc {
            x: cornerRadius
            y: 0
            radiusX: cornerRadius
            radiusY: cornerRadius
            direction: PathArc.Clockwise
          }
          PathLine { x: 0; y: 0 }
          PathLine { x: 0; y: cornerRadius }
        }
      }
    }
    
    // Top-right corner 
    PanelWindow {
      id: topRightCorner
      screen: scope.modelData
      implicitWidth: cornerRadius
      implicitHeight: cornerRadius
      color: "transparent"
      exclusiveZone: 0
      anchors {
        top: true
        right: true
      }
      margins.right: -5
      
      Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer
        
        ShapePath {
          strokeWidth: 0
          fillColor: barsColor
          startX: 0
          startY: 0
          PathArc {
            x: cornerRadius
            y: cornerRadius
            radiusX: cornerRadius
            radiusY: cornerRadius
            direction: PathArc.Clockwise
          }
          PathLine { x: cornerRadius; y: 0 }
          PathLine { x: 0; y: 0 }
        }
      }
    }
    
    // Bottom-left corner 
    PanelWindow {
      id: bottomLeftCorner
      screen: scope.modelData
      implicitWidth: cornerRadius
      implicitHeight: cornerRadius
      color: "transparent"
      exclusiveZone: 0
      anchors {
        bottom: true
        left: true
      }
      margins.left: -5
      
      Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer
        
        ShapePath {
          strokeWidth: 0
          fillColor: barsColor
          startX: cornerRadius
          startY: cornerRadius
          PathArc {
            x: 0
            y: 0
            radiusX: cornerRadius
            radiusY: cornerRadius
            direction: PathArc.Clockwise
          }
          PathLine { x: 0; y: cornerRadius }
          PathLine { x: cornerRadius; y: cornerRadius }
        }
      }
    }
    
    // Bottom-left corner -- quick note guys this controls the bottom right corner had to fix the margin issue)
    PanelWindow {
      id: bottomRightCorner
      screen: scope.modelData
      implicitWidth: cornerRadius
      implicitHeight: cornerRadius
      color: "transparent"
      exclusiveZone: 0
      anchors {
        bottom: true
        right: true
      }
      margins.right: -5
      
      Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer
        
        ShapePath {
          strokeWidth: 0
          fillColor: barsColor
          startX: 0
          startY: cornerRadius
          PathLine { x: cornerRadius; y: cornerRadius }
          PathLine { x: cornerRadius; y: 0 }
          PathArc {
            x: 0
            y: cornerRadius  
            radiusX: cornerRadius
            radiusY: cornerRadius
            direction: PathArc.Clockwise
          }
        }
      }
    }
  }
}