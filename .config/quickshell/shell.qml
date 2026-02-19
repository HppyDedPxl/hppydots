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
    Timer {
      interval:1
      running:true
      repeat:false
      onTriggered: {
        PackagesInfo.initService()
        SystemInfo.initService()
        MprisHandler.initService()
        VPNHandler.initService()
      }
    }

    LeftBar{
      id:leftBar
      content:[
        SpacerModule{}, 
        MprisModule{
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
          width:40
          orientation:3
        },
        SpacerModule{}
      ]
    }

    RightBar{
      id:rightBar
      content:[
        SpacerModule{},
        SpacerModule{},
        SpacerModule{},
      ]
    }
    
    BottomBar{
    id:bottomBar
    content:[

        SpacerModule {} ,
        ApplicationRunnerModule{
          textColor:AppearanceProvider.textColorSecondary
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
          orientation:2
          hyprlandOpenShortcut:"open_app_launcher"
        },
        SpacerModule {} ,
          
    ]}  

    Bar {
      id:topBar
      content:[
        SpacerModule {} ,
         
        SpacerModule {
          preferredWidth:800      
        } ,
        WorkspacesModule {
          bDoHighlight:false;
        },
        SpacerModule {},
        DividerModule {},
        WireguardModule {
          textColor:AppearanceProvider.textColorSecondary
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
        },
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
        KeyboardLayoutModule {
            usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
            textColor:AppearanceProvider.textColorSecondary
            bPopupOnHover:true
        },
        DividerModule{},
        
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
         ControlCenterModule {
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
          textColor:AppearanceProvider.textColorSecondary

         // width:40
         // orientation:1
        },   
        DividerModule {},
        TimeModule {
          bPopupOnHover:true
          textColor:AppearanceProvider.textColorSecondary
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
        },
        DividerModule {},

        SpacerModule {
          preferredWidth:20
        }      
      ]
    }
    OverlayNotificationArea{
      id:notificationArea
      visible:true         
    }
  }
}