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
          bDoHighlight:false;
        },
        SpacerModule {
        } ,
               DividerModule {},
        CpuModule {
          textColor:AppearanceProvider.textColorSecondary
        },
        DividerModule {},
         MemoryModule {
          textColor:AppearanceProvider.textColorSecondary
        },
        DividerModule {},

        TemperaturesModule {
          textColor:AppearanceProvider.textColorSecondary
        },
        DividerModule {},

        PackagesModule {
          textColor:AppearanceProvider.textColorSecondary
        },
        DividerModule {},

        NotificationsModule{
          bDoHighlight:true
          textColor:AppearanceProvider.textColorSecondary
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
        },
        DividerModule {},

        AudioModule{
          bDoHighlight:true
          bPopupOnHover:true
          textColor:AppearanceProvider.textColorSecondary
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
        },
        DividerModule {},

        
        TimeModule {
          bPopupOnHover:true
          textColor:AppearanceProvider.textColorSecondary
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
        },

        DividerModule {},

        BatteryModule {
          id: batteryModule
          textColor:AppearanceProvider.textColorSecondary
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
          
        },

        DividerModule {
          visible: batteryModule.visible
        },


        TrayModule {
          textColor:AppearanceProvider.textColorSecondary
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
          bPopupOnHover:true
        },
        DividerModule {},

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

  //   SlimBar {
  //     id:topBar
  //     leftBarWidth:300
  //     rightBarWidth:300
  //     leftContent: [
  //       SpacerModule{
  //         preferredWidth: 20
  //       },
  //       WorkspacesModule {
  //         bDoHighlight:false;
  //         width:180
  //       }
  //     ]
  //     rightContent: [
  //       // CpuModule {
  //       //   textColor:AppearanceProvider.textColorSecondary
  //       // },
  //       //  MemoryModule {
  //       //   textColor:AppearanceProvider.textColorSecondary
  //       // },
  //       // TemperaturesModule {
  //       //   textColor:AppearanceProvider.textColorSecondary
  //       // },
  //       SpacerModule{},
  //       PackagesModule {
  //         textColor:AppearanceProvider.textColorSecondary
  //       },
  //       NotificationsModule{
  //         bDoHighlight:true
  //         textColor:AppearanceProvider.textColorSecondary
  //         usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
  //       },
  //       AudioModule{
  //         bDoHighlight:true
  //         bPopupOnHover:true
  //         textColor:AppearanceProvider.textColorSecondary
  //         usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
  //       },
  // TrayModule {
  //         textColor:AppearanceProvider.textColorSecondary
  //         usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
  //         bPopupOnHover:true
  //       },
  //       SpacerModule {
  //         preferredWidth:20
  //       }
  //     ]

      
  //   }
  }
}