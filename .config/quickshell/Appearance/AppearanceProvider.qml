pragma Singleton
import Quickshell
import "../Services"

Singleton {

    id: root
    property var backgroundColor : Pywal.color4;
    property var textColor : Pywal.foreground;
    property var textColorDark : Pywal.background;
    property var highlightColor : Pywal.color1
    property var activeColor : Pywal.color7
    property var inactiveColor: Pywal.color8
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