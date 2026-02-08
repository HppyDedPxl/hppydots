import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts
import Quickshell
import Quickshell.Io // for Process
import QtQuick
import "./Services"
import "./Modules"

Variants{
  model: Quickshell.screens;
  delegate : Component {
   PanelWindow {
      required property var modelData
      screen: modelData
      anchors {
        top: true
        left: true
        right: true
      }
      color:'transparent'
      height:45
      exclusiveZone:45

      Item {
        
        height: 45
        width: parent.width
        Rectangle {
          anchors.fill: parent
          color : AppearanceProvider.backgroundColor
        }
      
        Row {
          anchors.fill : parent
          id : topRow
          spacing:6
        
        
          ModuleTime {
            widthHovered:175
            widthUnhovered:75
          }
                    ModuleTime {
            widthHovered:175
            widthUnhovered:75
          }
                    ModuleTime {
            widthHovered:175
            widthUnhovered:75
          }
   
        
           
      //    ModuleTime {}
        
        //   ModuleWorkspaces {
        //     data : modelData
        // }   
      }
      }

     
    
    }
  }
}

