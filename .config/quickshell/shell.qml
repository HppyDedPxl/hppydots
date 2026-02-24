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
      Shape {
        id:deco
        layer.enabled:true
        ShapePath {
          strokeColor:'transparent'
          strokeWidth:0
          fillColor: AppearanceProvider.highlightColor
          startX:modelData.width
          startY :modelData.height/1.3
          PathLine {
            x: modelData.width
            y: modelData.height/1.3
          }
          PathLine{
            x:modelData.width
            y:modelData.height
          }
          PathLine{
            x:modelData.width/1.2
              y:modelData.height
          }
        }
        Shape {
          ShapePath {
            strokeColor:'transparent'
            strokeWidth:0
            fillColor: AppearanceProvider.accentColor
            startX:modelData.width
            startY :modelData.height/1.2
            PathLine {
              x: modelData.width
              y: modelData.height/1.2
            }
            PathLine{
              x:modelData.width
              y:modelData.height
            }
            PathLine{
              x:modelData.width/1.1
              y:modelData.height
            }
          }
          Shape {
            ShapePath {
              strokeColor:'transparent'
              strokeWidth:0
              fillColor: AppearanceProvider.backgroundColor
              startX:modelData.width
              startY :modelData.height/1.1
              PathLine {
                x: modelData.width
                y: modelData.height/1.1
              }
              PathLine{
                x:modelData.width
                y:modelData.height
              }
              PathLine{
                x:modelData.width/1.05
                y:modelData.height
              }
            }
          }
        }
      }
    }

    ScreenBar{
      id:leftBar
      overlayDecorator: overlayDecoration
      barWidth: AppearanceProvider.leftBarWidth
      barPadding: AppearanceProvider.leftBarPadding
      orientation: 3
      withAdornments: false
      adornmentSize: AppearanceProvider.bottomBarAdornmentSize
      content:[
        SpacerModule{}, 
        MprisModule{
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
          width:40
        },
        SpacerModule{}
      ]
    }

    ScreenBar{
      id:rightBar
      barWidth: AppearanceProvider.rightBarWidth
      barPadding: AppearanceProvider.rightBarPadding
      orientation: 1
      overlayDecorator: overlayDecoration
      withAdornments:false
      leftDecoratorColor: AppearanceProvider.backgroundColor
      adornmentSize: AppearanceProvider.bottomBarAdornmentSize
      debug:false
      content:[
        SpacerModule{},
        SpacerModule{},
        SpacerModule{},
      ]
    }

    
    ScreenBar{
      id:bottomBar
      overlayDecorator: overlayDecoration
      barWidth: AppearanceProvider.bottomBarWidth
      barPadding: AppearanceProvider.bottomBarPadding
      withAdornments:true
      adornmentSize: AppearanceProvider.bottomBarAdornmentSize
      rightDecoratorColor: AppearanceProvider.backgroundColor
      orientation: 2
      content:[

          SpacerModule {} ,
          ApplicationRunnerModule{
            textColor:AppearanceProvider.textColorSecondary
            usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
            hyprlandOpenShortcut:"open_app_launcher"
          },
          SpacerModule {} ,
            
      ]}  

    ScreenBar {
      id:topBar
      overlayDecorator: overlayDecoration
      barWidth: AppearanceProvider.topBarWidth
      barPadding: AppearanceProvider.topBarPadding
      adornmentSize: AppearanceProvider.topBarAdornmentSize
      withAdornments:true
      orientation : 0

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

    OverlayNotificationArea{
      id:notificationArea
      visible:true         
    }

  }
}