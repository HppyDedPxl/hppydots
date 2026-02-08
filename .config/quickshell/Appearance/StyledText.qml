import Quickshell
import QtQuick
Text
{
    font.family: AppearanceProvider.primaryFont
    font.pointSize: AppearanceProvider.primaryFontSize
    color: baseModule ? baseModule.textColor : AppearanceProvider.textColor
}