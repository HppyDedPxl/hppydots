pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell
import QtQuick.Layouts
import "../Modules"
import "../Services"
import "../Appearance"
import "../Bar"
import "../Widgets"
import Quickshell.Hyprland



Scope {
    Component { 
      id:overlayDecoration2
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

    ScreenBarNotch {
      id:topBar
      barWidth: AppearanceProvider.topBarWidth
      barPadding: AppearanceProvider.topBarPadding
      adornmentSize: AppearanceProvider.topBarAdornmentSize
      withAdornments:true
      orientation : 0
      contentLeft:[
      SpacerModule{
        preferredWidth: 20
      },
      TemperaturesModule {
          textColor:AppearanceProvider.textColorSecondary
        },
          NotificationsModule{
          bDoHighlight:true
          textColor:AppearanceProvider.textColorSecondary
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
        },
          KeyboardLayoutModule {
            usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
            textColor:AppearanceProvider.textColorSecondary
            bPopupOnHover:true
        },
                BatteryModule {
          id: batteryModule
          textColor:AppearanceProvider.textColorSecondary
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
          
        },
        BluetoothModule {
          id: bluetootModule
           textColor:AppearanceProvider.textColorSecondary
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
          
        },
        NetworkModule {
          id: networkModule
          textColor: AppearanceProvider.textColorSecondary
          usedBackgroundColor: AppearanceProvider.backgroundColorSecondary
        },
      ]
      content:[

        WorkspacesModule {
          bDoHighlight:false
          fullsizeMode : true   
        },
         ApplicationRunnerModule{
          width:0
            textColor:AppearanceProvider.textColorSecondary
            usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
            hyprlandOpenShortcut:"open_app_launcher"
            doPopupScaleAnimation:false
          },

      ]
      contentRight: [
        AudioModule{
          bDoHighlight:true
          bPopupOnHover:true
          textColor:AppearanceProvider.textColorSecondary
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
        },
        TimeModule {
          bPopupOnHover:true
          textColor:AppearanceProvider.textColorSecondary
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
        },
        SpacerModule{
          preferredWidth: 20
        },
      ]
    }

    OverlayNotificationArea{
      id:notificationArea
      visible:true         
    }
}