//@ pragma UseQApplication
pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell
import QtQuick.Layouts
import "./Modules"
import "./Services"
import "./Appearance"
import "./Bar"
import "./Widgets"
import Quickshell.Hyprland


Variants {
  
  model: Quickshell.screens
  Scope {
    id: scope
    required property ShellScreen modelData
    Timer{
      interval:1
      running:true
      repeat:false
      onTriggered: {
        PackagesInfo.initService()
        SystemInfo.initService()
        }
    }
   
    Bar {
      id:topBar
      content:[
        SpacerModule {
          preferredWidth:50
        } ,

        WorkspacesModule {
          width:200
          bDoHighlight:false;
        },
        SpacerModule {
        } ,
        TemperaturesModule {
          textColor:AppearanceProvider.textColorDark
          width:80
        },

        PackagesModule {
          textColor:AppearanceProvider.textColorDark
          width:45
        },

        NotificationsModule{
          width:45
          bDoHighlight:true
          textColor:AppearanceProvider.textColorDark
          usedBackgroundColor:AppearanceProvider.textColor
        },
 
        AudioModule{
          width:125
          bDoHighlight:true
          bPopupOnHover:true
          textColor:AppearanceProvider.textColorDark
          usedBackgroundColor:AppearanceProvider.textColor
        },

        TimeModule {
          width:75
          bPopupOnHover:true
          textColor:AppearanceProvider.textColorDark
          usedBackgroundColor:AppearanceProvider.textColor
        },
        TrayModule {
          textColor:AppearanceProvider.textColorDark
          usedBackgroundColor:AppearanceProvider.textColor
          width:50
          bPopupOnHover:true
        },
        SpacerModule {
          preferredWidth:20
        }      
      ]
      OverlayNotificationArea{
              visible:true
              anchor.window : topBar
              anchor.rect.x: topBar.width-width-25
              anchor.rect.y: 45
              implicitWidth:300
              implicitHeight: 25 + 800       
      }
    }
  }
}