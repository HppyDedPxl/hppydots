import "../Appearance"
import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell

Item {
    id: root

    property var days: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    property var daysLong: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    property var curDate: {
        new Date();
    }
    property var curDay: new Date()
    property var months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    property var bInitialized: false
    property var displayedItenerary: itenerary

    function setDisplayedItenerary(dayItenerary) {
        displayedItenerary.clear();
        for (let i = 0; i < dayItenerary.count; ++i) {
            displayedItenerary.append(dayItenerary.get(i));
        }
    }

    function getFirstMonday() {
        var curMonth = curDate.getMonth();
        var itDate = new Date(curDate);
        while (itDate.getMonth() == curMonth || itDate.getDay() != 1)itDate = new Date(itDate - (3600 * 24))
        return itDate;
    }

    function getLastSunday() {
        var curMonth = curDate.getMonth();
        var itDate = new Date(curDate);
        for (let i = 0; i < 6; i++) {
            itDate.setDate(itDate.getDate() + (1));
        }
        return itDate;
    }

    function nextMonth() {
        curDate.setMonth(curDate.getMonth() + 1);
    }

    function previousMonth() {
        curDate.setMonth(curDate.getMonth() - 1);
    }

    function isToday(day) {
        var today = new Date();
        return day.getDate() == today.getDate() && day.getMonth() == today.getMonth() && day.getYear() == today.getYear();
    }

    function updateMonth() {
        var firstMonday = getFirstMonday();
        dayList.clear();
        dayList.append({
            "date": firstMonday
        });
        for (let i = 0; i < 41; i++) {
            firstMonday.setDate(firstMonday.getDate() + 1);
            dayList.append({
                "date": firstMonday
            });
        }
        monthText.text = months[curDate.getMonth()];
    }

    function timeToString(time) {
        return time.getHours().toString().padStart(2, "0").padEnd(2, "0") + ":" + time.getMinutes().toString().padStart(2, "0").padEnd(2, "0");
    }

    Component.onCompleted: {
        updateMonth();
    }

    ListModel {
        id: dayList
    }

    ListModel {
        id: itenerary
    }

    Rectangle {
        property var currentDate: clock.date

        anchors.fill: parent
        anchors.leftMargin: 10
        color: "transparent"

        ColumnLayout {
            anchors.fill: parent

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.preferredHeight: 20
                Layout.leftMargin:30

                StyledButton {
                    Layout.fillHeight: true
                    text: "<"
                    border.width: 0
                    color: "transparent"
                    onClick: () => {
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

                        anchors.centerIn: parent
                        fontSizeMode: Text.Fit
                        font.bold: true
                        color: AppearanceProvider.textColor
                        text: months[curDate.getMonth()]
                    }

                }

                StyledButton {
                    Layout.fillHeight: true
                    border.width: 0
                    text: ">"
                    color: "transparent"
                    Layout.rightMargin:30
                    onClick: () => {
                        nextMonth();
                        updateMonth();
                    }
                }

            }

            Rectangle {
                Layout.preferredHeight: 3
            }

            

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"

                ColumnLayout {
                    anchors.centerIn: parent
                    height: parent.height
                    width: parent.width - 75

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: false
                        Layout.preferredHeight: 10

                        Repeater {
                            model: {
                                root.days.length;
                            }

                            Rectangle {
                                color: "transparent"
                                Layout.fillWidth: true
                                Layout.fillHeight: true

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

                    Rectangle {
                        Layout.preferredHeight: 3
                    }

                    GridLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        columns: {
                            root.days.length;
                        }
                        rows: 6
                        uniformCellHeights: true

                        Repeater {
                            id: repeater

                            model: dayList
                            delegate: CalendarDayEntryButton {}
                        }

                    }

                }

            }

            Rectangle {
                Layout.preferredHeight: 10
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 20

                ColumnLayout{
                    Layout.preferredHeight: 40
                    

                Text {
                    id: scheduleText

                    Layout.preferredHeight: 20
                    color: AppearanceProvider.textColor
                    Layout.fillWidth: true
                    text: "Schedule"
                    font.bold: true
                }
                Text {
                    id: scheduleCurrentDayText

                    Layout.preferredHeight: 20
                    color: AppearanceProvider.textColor
                    Layout.fillWidth: true
                    text: root.daysLong[root.curDay.getDay()] + ", " + root.months[root.curDay.getMonth()] + " " + root.curDay.getDate()
                    font.italic: true
                    font.pointSize: 10
                    
                }
                }
                

                StyledButton {
                    Layout.preferredHeight: 20
                    border.width: 0
                    color: "transparent"
                    fontSize: 12
                    text: "Sync"
                    onClick: () => {
                        CalendarEventsProvider.sync();
                    }
                }

            }

            Rectangle {
                Layout.fillWidth: true
                // Layout.fillHeight: true
                Layout.preferredHeight: 200
                color: "transparent"
                // border.color: AppearanceProvider.textColor
                radius: AppearanceProvider.rounding

                ColumnLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5

                    Text {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        visible: displayedItenerary.count == 0
                        text: "Nothing planned"
                        color: AppearanceProvider.textColor
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Repeater {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        visible: displayedItenerary.count > 0
                        model: displayedItenerary
                        delegate: CalendarScheduleListEntry {}
                    }

                }

            }

            Rectangle {
                Layout.preferredHeight: 20
            }

        }

    }

}
