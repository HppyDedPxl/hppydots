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
    
    property var backgroundColor : Pywal.color4;
    property var textColor :  getPercievedLuminance(backgroundColor) < Pywal.foreground ? Pywal.foreground : Pywal.background;

    property var backgroundColorSecondary: Pywal.foreground;
    property var textColorSecondary : Pywal.background;
    
    property var highlightColor : Pywal.color1
    property var highlightTextColor: getPercievedLuminance(highlightColor) < Pywal.foreground ? Pywal.foreground : Pywal.background;
   
    property var activeColor : Pywal.color7
    property var activeTextColor: getPercievedLuminance(activeColor) < Pywal.foreground ? Pywal.foreground : Pywal.background;
   
    property var inactiveColor: Pywal.color8
    property var inactiveTextColor: getPercievedLuminance(inactiveTextColor) < Pywal.foreground ? Pywal.foreground : Pywal.background;
    
    property var accentColor: Pywal.color5
    property var accentColorLighter: Pywal.color6


    property var primaryFont : "JetBrainsMono Nerd Font"
    property var primaryFontSize : 12

    property var topBarWidth : 45
    property var topBarPadding: 60

    property var rounding: 20
    property var topBarAdornmentSize: 35


    property var shadowColor: 'black'
    property var shadowBlur : 10
    property var shadowSpread : 5
    property var shadowOffsetX : 0
    property var shadowOffsetY : 1

    property var popoutAnimDuration: 500
}