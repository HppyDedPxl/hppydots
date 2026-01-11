/***************************************************************************
* Copyright (c) 2013 Reza Fatahilah Shah <rshah0385@kireihana.com>
* Copyright (c) 2013 Abdurrahman AVCI <abdurrahmanavci@gmail.com>
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge,
* publish, distribute, sublicense, and/or sell copies of the Software,
* and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included
* in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
* OR OTHER DEALINGS IN THE SOFTWARE.
*
***************************************************************************/

import QtQuick 2.0
import SddmComponents 2.0



Rectangle {
    width: 640
    height: 480

    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property int sessionIndex: session.index

    TextConstants { id: textConstants }

    Connections {
        target: sddm
        onLoginSucceeded: {
        }
        onInformationMessage: {
        }
        onLoginFailed: {
            pw_entry.text = ""
        }
    }

    Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }



    Rectangle {
        anchors.fill: parent
        color: "transparent"
        //visible: primaryScreen
   
        Rectangle {
            id: test
            width: 650; height: parent.height
            color: '#75161616'
            border.color: "#000000"
            border.width: 2
            x:0;y:0


            Item {
                anchors.margins: 20
                anchors.fill: parent

                Text {
                    opacity:0
                    height: 50
                    anchors.top: parent.top
                    anchors.left: parent.left; anchors.right: parent.right

                    color: "#0b678c"
                    

                    text: sddm.hostName

                    font.bold: true
                    font.pixelSize: 18
                }

                Clock
                {
                    y:250
                    
                    width:parent.width
                }

                Column {
                    anchors.centerIn: parent

                    Row {
                        id: trow
                        height: 70;
                        TextBox {
                            id: user_entry

                            width: 350; height: 45
                            anchors.verticalCenter: parent.verticalCenter;
                            radius: 20
                            color: '#b7cacaca'
                            borderColor: '#cfcfcf'
                            hoverColor: "#ffffff"
                            textColor: "#303030"
                            focusColor: "#ffffff"
                            font.bold: true
                            font.pixelSize: 18
                            text: userModel.lastUser

                            KeyNavigation.backtab: layoutBox; KeyNavigation.tab: pw_entry
                        }
                    }

                    Row {

                        height: 70;

                        PasswordBox {
                            id: pw_entry
                            width: 350; height: 45
                            anchors.verticalCenter: parent.verticalCenter;
                            anchors.margins:20;
                            radius: 20
                            color: '#b7cacaca'
                            borderColor: '#cfcfcf'
                            hoverColor: "#ffffff"
                            textColor: "#303030"
                            focusColor: "#ffffff"
                            font.bold: true
                            font.pixelSize: 18
                            tooltipBG: "CornflowerBlue"

                            KeyNavigation.backtab: user_entry; KeyNavigation.tab: login_button

                            Keys.onPressed: {
                                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                    sddm.login(user_entry.text, pw_entry.text, sessionIndex)
                                    event.accepted = true
                                }
                            }
                        }
                    }
                }

            }
        }
    }

     Rectangle {
        opacity:0
        id: actionBar
        anchors.top: parent.top;
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width; height: 40

        Row {
            anchors.left: parent.left
            anchors.margins: 5
            height: parent.height
            spacing: 5

            Text {
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter

                text: textConstants.session
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
            }

            ComboBox {
                id: session
                width: 245
                anchors.verticalCenter: parent.verticalCenter

                arrowIcon: "angle-down.png"

                model: sessionModel
                index: sessionModel.lastIndex

                font.pixelSize: 14

                KeyNavigation.backtab: hibernate_button; KeyNavigation.tab: layoutBox
            }

            Text {
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter

                text: textConstants.layout
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
            }

            LayoutBox {
                id: layoutBox
                width: 90
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14

                arrowIcon: "angle-down.png"

                KeyNavigation.backtab: session; KeyNavigation.tab: user_entry
            }
        }
    }

    Component.onCompleted: {
        if (user_entry.text === "")
            user_entry.focus = true
        else
            pw_entry.focus = true
    }


}