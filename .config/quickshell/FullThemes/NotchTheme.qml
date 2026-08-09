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

    Wallpaper{
      themeExclusionZonesTop: AppearanceProvider.topBarWidth
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
        CpuModule {
          textColor:AppearanceProvider.textColorSecondary
        },
         MemoryModule {
          textColor:AppearanceProvider.textColorSecondary
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
        AudioModule{
          bDoHighlight:true
          bPopupOnHover:true
          textColor:AppearanceProvider.textColorSecondary
          usedBackgroundColor:AppearanceProvider.backgroundColorSecondary
          bMinimalDisplay: true
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
        NotificationsModule{
          bDoHighlight:true
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

    WallpaperPickerFull{
      id: _picker
    }

    ModalWindow{
      id:modalWindow
    }

    Component.onCompleted: {
        ModalWindowProvider.registerModalComponent(scope.modelData,modalWindow)
    }
}