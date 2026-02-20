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

    Component { 
        id:overlayDecoration

      Rectangle {
            height: 1000
            width: 1000
            x:900
            y:500
            rotation: 235
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                    position: 0
                    color: AppearanceProvider.backgroundColor
                }
                GradientStop {
                    position: 0.17
                    color: AppearanceProvider.backgroundColor
                }
                GradientStop {
                    position: 0.170001
                    color: AppearanceProvider.accentColor
                }
                GradientStop {
                    position: 0.18
                    color: AppearanceProvider.accentColor
                }
                GradientStop {
                    position: 0.180001
                    color: AppearanceProvider.accentColorLighter
                }
                GradientStop {
                    position: 0.19
                    color: AppearanceProvider.accentColorLighter
                }
                GradientStop {
                    position: 0.190001
                    color: AppearanceProvider.backgroundColorSecondary
                }
            }
        }
    }

    LeftBar{
      id:leftBar
      overlayDecorator: overlayDecoration

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
      overlayDecorator: overlayDecoration

      content:[
        SpacerModule{},
        SpacerModule{},
        SpacerModule{},
      ]
    }
    
    BottomBar{
    id:bottomBar
      overlayDecorator: overlayDecoration

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
      overlayDecorator: overlayDecoration
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