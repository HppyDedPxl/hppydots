import QtQuick
import Quickshell
import "../Bar"
import "../Appearance"
import "../Modules"

Scope {
    ScreenBarAero {
        barWidth: AppearanceProvider.topBarWidth
        barPadding: AppearanceProvider.topBarPadding
        debug: false
              content:[
        SpacerModule {
          preferredWidth:20
        } ,

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
        SpacerModule {} ,

        
        WorkspacesModule {
          bDoHighlight:false;
        },
        SpacerModule {},

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
}