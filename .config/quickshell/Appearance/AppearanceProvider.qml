pragma Singleton
import Quickshell
import "../Services"

Singleton {

    function getPercievedLuminance(color){
        let Ys = Math.pow(color.r,2.2) * 0.2126 +
             Math.pow(color.g,2.2) * 0.7152 +        
             Math.pow(color.b,2.2) * 0.0722;
             return Ys;
    }

    property var luminanceFlipPoint: 0.36

    id: root
    
    property var backgroundColor : Pywal.color1;
    property var textColor :  getPercievedLuminance(backgroundColor) < luminanceFlipPoint ? Pywal.foreground : Pywal.background;

    property var backgroundColorSecondary: getPercievedLuminance(Pywal.color1) > .17 ? Pywal.color0 : Pywal.color1;
    property var textColorSecondary : getPercievedLuminance(backgroundColorSecondary) < luminanceFlipPoint ? Pywal.foreground : Pywal.background;
    
    property var highlightColor : Pywal.color4
    property var highlightTextColor: getPercievedLuminance(highlightColor) < luminanceFlipPoint ? Pywal.foreground : Pywal.background;
   
    property var activeColor : Pywal.color7
    property var activeTextColor: getPercievedLuminance(activeColor) < luminanceFlipPoint ? Pywal.foreground : Pywal.background;
   
    property var inactiveColor: Pywal.color8
    property var inactiveTextColor: getPercievedLuminance(inactiveColor) < luminanceFlipPoint ? Pywal.foreground : Pywal.background;
    
    property var accentColor: Pywal.color2
    property var accentColorLighter: Pywal.color3


    property var primaryFont : "JetBrainsMono Nerd Font"
    property var primaryFontSize : 12

    property var topBarWidth : 40
    property var leftBarWidth: 15
    property var rightBarWidth: 15
    property var bottomBarWidth:15
    property var topBarPadding: 60
    property var leftBarPadding : 40
    property var bottomBarPadding: 45
    property var rightBarPadding : 10

    property var slimBarWidth : 10
    property var rounding: 20
    property var topBarAdornmentSize: 35
    property var bottomBarAdornmentSize: 35


    property var shadowColor: 'black'
    property var shadowBlur : 10
    property var shadowSpread : 5
    property var shadowOffsetX : 0
    property var shadowOffsetY : 1

    property var popoutAnimDuration: 400
}