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

  // PanelWindow {
  //   color:'transparent'
  //   anchors {
  //       top: true
  //       bottom: true
  //       right: true
  //       left:true
  //   }
  //   exclusiveZone:0
  //   mask: Region{id:msk;regions:[]}
  //   Rectangle{
  //     anchors.fill:parent
  //     opacity:0.1
  //     Shape {
  //       ShapePath {
  //         strokeColor:white
  //         fillGradient: LinearGradient {
  //               orientation: Gradient.Horizontal
  //               GradientStop {
  //                   position: 0
  //                   color: AppearanceProvider.backgroundColor
  //               }
  //               GradientStop {
  //                   position: 0.5
  //                   color: AppearanceProvider.backgroundColor
  //               }
  //               GradientStop {
  //                   position: 0.50000001
  //                   color: AppearanceProvider.accentColor
  //               }
  //               GradientStop {
  //                   position: 0.7
  //                   color: AppearanceProvider.accentColor
  //               }
  //               GradientStop {
  //                   position: 0.70000001
  //                   color: AppearanceProvider.accentColorLighter
  //               }
  //               GradientStop {
  //                   position: 0.9
  //                   color: AppearanceProvider.accentColorLighter
  //               }
  //               GradientStop {
  //                   position: 0.90000001
  //                   color: AppearanceProvider.backgroundColorSecondary
  //               }
  //           }
  //         startX:modelData.width
  //         startY :modelData.height/1.5

  //         PathLine {
  //           x: modelData.width
  //           y: modelData.height/1.5
  //         }
  //         PathLine{
  //           x:modelData.width
  //           y:modelData.height
  //         }
  //         PathLine{
  //            x:modelData.width/1.5
  //             y:modelData.height
  //         }

  //       }
  //   }
    
  // }
    Component { 
      id:overlayDecoration
      Shape {
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

      // Rectangle {
      //       height: 1200
      //       width: 600
      //       x:modelData.width-(width/1.7)
      //       y:modelData.height-(height/1.7)
      //       rotation: 235
      //       gradient: Gradient {
      //           orientation: Gradient.Horizontal
      //           GradientStop {
      //               position: 0
      //               color: AppearanceProvider.backgroundColor
      //           }
      //           GradientStop {
      //               position: 0.5
      //               color: AppearanceProvider.backgroundColor
      //           }
      //           GradientStop {
      //               position: 0.50000001
      //               color: AppearanceProvider.accentColor
      //           }
      //           GradientStop {
      //               position: 0.7
      //               color: AppearanceProvider.accentColor
      //           }
      //           GradientStop {
      //               position: 0.70000001
      //               color: AppearanceProvider.accentColorLighter
      //           }
      //           GradientStop {
      //               position: 0.9
      //               color: AppearanceProvider.accentColorLighter
      //           }
      //           GradientStop {
      //               position: 0.90000001
      //               color: AppearanceProvider.backgroundColorSecondary
      //           }
      //       }
      //   }
    
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