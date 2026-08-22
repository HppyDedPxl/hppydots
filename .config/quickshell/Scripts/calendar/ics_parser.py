
from datetime import datetime
from zoneinfo import ZoneInfo;

class ICSEvent:
    UID = ""
    DTSTAMP = 0
    SUMMARY = ""
    DTSTART = 0
    DTEND = 0
    RRULE = ""

class ICSParser:
    def __init__(self,filepath):
        self.filepath = filepath
        self.events = []
        self.parse(self.filepath)

    def parse_datetime_string(self,str):
        tzp,dtp = str.split(':')
        dtp=dtp.rstrip()
        tzpp = tzp.split('=')
        timezone = "Europe/Berlin" if tzpp[1] == "DATE"  else tzpp[1]
        format = "%Y%m%dT%H%M%S" if len(dtp) != 8  else "%Y%m%d"
        ndt = datetime.strptime(dtp, format)
        dt = ndt.replace(tzinfo=ZoneInfo(timezone))
        return dt
        

    def parse(self,filepath):
        with open(filepath,"r") as f:
            curCalendarEvent = ICSEvent()
            for line in f:
                if line.startswith("BEGIN:VEVENT"):
                    curCalendarEvent = ICSEvent()
                elif line.startswith("UID:"):
                    curCalendarEvent.UID = line[4:]
                elif line.startswith("SUMMARY:"):
                    curCalendarEvent.SUMMARY = line[8:]
                elif line.startswith("DTSTART;"):
                    curCalendarEvent.DTSTART = self.parse_datetime_string(line[8:])
                elif line.startswith("DTEND;"):
                    curCalendarEvent.DTEND = self.parse_datetime_string(line[6:])
                elif line.startswith("RRULE"):
                    curCalendarEvent.RRULE = line.split(':')[1].rstrip()
                    if "UNTIL=" in curCalendarEvent.RRULE:
                        if "Z" not in curCalendarEvent.RRULE:
                            curCalendarEvent.RRULE = curCalendarEvent.RRULE +"T000000Z"
                    else:
                        curCalendarEvent.RRULE = curCalendarEvent.RRULE + ";UNTIL=20350101T000000Z"
                elif line.startswith("END:VEVENT"):
                    self.events.append(curCalendarEvent)
            
            print(len(self.events))



