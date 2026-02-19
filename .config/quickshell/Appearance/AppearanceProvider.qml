pragma Singleton
import Quickshell
import "../Services"

Singleton {
    id: root

    function getPercievedLuminance(color){
        let Ys = Math.pow(color.r,2.2) * 0.2126 +
             Math.pow(color.g,2.2) * 0.7152 +        
             Math.pow(color.b,2.2) * 0.0722;
             return Ys;
    }

    function getColorDifference(cA,cB){
        return ( Math.abs(cA.r - cB.r) +  Math.abs(cA.b - cB.b) +  Math.abs(cA.g - cB.g))  ;
    }

    property var luminanceFlipPoint: 0.36

    property var backgroundColorSecondary: getPercievedLuminance(Pywal.color1) > .092 ? Pywal.color0 : Pywal.color1;
    property var textColorSecondary : getPercievedLuminance(backgroundColorSecondary) < luminanceFlipPoint ? Pywal.foreground : Pywal.background;
    
    property var backgroundColor : getColorDifference(Pywal.color1,backgroundColorSecondary) > .4 ?  Pywal.color1 : Pywal.color5;
    property var textColor :  getPercievedLuminance(backgroundColor) < luminanceFlipPoint ? Pywal.foreground : Pywal.background;

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
    property var bottomBarWidth:35
    property var topBarPadding: 60
    property var leftBarPadding : 40
    property var bottomBarPadding: 45
    property var rightBarPadding : 40

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

    function getEffectiveScreenWidth(screen){
        return screen.width - leftBarWidth - rightBarWidth;
    }

    function getEffectiveScreenHeight(screen){
        return screen.height - topBarWidth - bottomBarWidth;
    }
}