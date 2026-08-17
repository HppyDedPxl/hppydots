import Quickshell
import QtQuick
import QtQuick.Layouts
import "../Appearance"

Item {
    id:root
    property var days: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    property var curDate : {new Date()};
    property var months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    function getFirstMonday(){
        var curMonth = curDate.getMonth();
        var itDate = new Date(curDate);
        console.log("get first monday")
        while(itDate.getMonth() == curMonth || itDate.getDay() != 1){
            itDate = new Date(itDate - (3600*24));
        }
        console.log(itDate);
        return itDate;
    }
    function getLastSunday(){
        var curMonth = curDate.getMonth();
        var itDate = new Date(curDate);
        for (let i = 0; i < 6 ; i++) {
            itDate.setDate(itDate.getDate() + (1));
        }
        return itDate;
    }

    function nextMonth(){
        curDate.setMonth(curDate.getMonth() + 1);
    }
    function previousMonth(){
        curDate.setMonth(curDate.getMonth() - 1);
    }

    function isToday(day) {
        var today = new Date();
        return day.getDate() == today.getDate() && day.getMonth() == today.getMonth() && day.getYear() == today.getYear();
    }

    function updateMonth(){
        var firstMonday = getFirstMonday();
        dayList.clear();
        dayList.append({"date":firstMonday});
        for ( let i = 0 ; i < 41 ; i++){
            firstMonday.setDate(firstMonday.getDate() + 1);
            dayList.append({"date":firstMonday});
        }
        monthText.text = months[curDate.getMonth()];
    }

    Component.onCompleted: {
        updateMonth();
    }

    ListModel {
        id: dayList
    }

    Rectangle {
        anchors.fill : parent
        anchors.leftMargin:10
        property var currentDate: clock.date
        color: "transparent"
        ColumnLayout {
            anchors.fill:parent
            RowLayout {
                Layout.fillWidth:true
                Layout.preferredHeight:2
                StyledButton {
                    Layout.fillHeight:true;
                    text: "<"
                    border.width : 0
                    onClick: ()=>{
                        previousMonth();
                        updateMonth();
                       
                    }
                }
                Rectangle {
                    color: "transparent"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    StyledText {
                        id: monthText
                        anchors.centerIn:parent
                        fontSizeMode: Text.Fit
                        font.bold: true
                        color: AppearanceProvider.textColor
                        text: months[curDate.getMonth()]
                    }
                }
                StyledButton {
                    Layout.fillHeight: true
                    border.width : 0

                    text: ">"
                    onClick: ()=>{
                        nextMonth();
                        updateMonth();
                    }
                }
            }
            Rectangle{
                Layout.preferredHeight:3
            }
            RowLayout {
                Layout.fillWidth:true
                Repeater {
                    model: {root.days.length}
                    Rectangle{
                        color: "transparent"
                        Layout.fillWidth:true
                        Layout.fillHeight:true
                        Text {
                            color: AppearanceProvider.textColor
                            font.bold: true
                            fontSizeMode: Text.Fit
                            anchors.centerIn: parent
                            text: days[index]
                        }
                    }        
                }
            }
                    Rectangle{
                Layout.preferredHeight:3
            }
            Component {
                id: dayComponent
                Rectangle {
                    required property string model
                    required property int index
                    required property var date
                    id: dayRoot
                    color: "transparent"
                    Layout.fillWidth:true
                    Layout.fillHeight:true
                    Rectangle {

                        radius: width
                        opacity: date.getMonth() == root.curDate.getMonth() ? 1.0 : 0.2
                        color: isToday(date) ? AppearanceProvider.highlightColor :AppearanceProvider.backgroundColor
                        anchors.centerIn:parent
                        width: parent.width > parent.height ? parent.height : parent.width
                        height: width
                        Text {
                            color: isToday(date) ? AppearanceProvider.highlightTextColor : AppearanceProvider.textColor
                            anchors.centerIn:parent
                            text: {date.getDate()}
                        }
                    }    
                }  
            }

            GridLayout {
                Layout.fillWidth:true
                columns: { root.days.length }
                rows: 6
                uniformCellHeights:true

                Repeater {
                    id: repeater
                    model: dayList
                    delegate: dayComponent
                }
            }
        }
    }
}