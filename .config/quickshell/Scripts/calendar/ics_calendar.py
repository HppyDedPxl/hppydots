from ics_parser import *
from dateutil.rrule import *
import datetime
import copy


class ICSCalendar:
    def __init__(self, ):
        self.events = []

    def AddEvents(self, events: list[ICSEvent]):
        self.events += events

    def IsInRange(self, time: datetime, begin: datetime, end: datetime):
        return time > begin and time < end

    def GetEventsInTimeRange(self, begin: datetime, end: datetime):
        found = []
        
        for event in self.events:
            if event.RRULE == "":
                if self.IsInRange(event.DTSTART,begin,end) or self.IsInRange(event.DTEND,begin,end):
                    found.append(event)

            else:
                bFound = False
                revents = list(rrulestr(event.RRULE,dtstart=event.DTSTART))
                revents_end = list(rrulestr(event.RRULE,dtstart=event.DTEND))
                i = 0
                for revent in revents:
                    i = i +1
                    if self.IsInRange(revent,begin,end) or self.IsInRange(revent,begin,end):
                        event_copy = copy.deepcopy(event)
                        event_copy.DTSTART = revent
                        event_copy.DTEND = revents_end[i-1]
                        found.append(event_copy)
                        bFound = True
                if bFound:
                    continue
                revents = list(rrulestr(event.RRULE,dtstart=event.DTEND))
                revents_end = list(rrulestr(event.RRULE,dtstart=event.DTEND))
                i = 0
                for revent in revents:
                    if self.IsInRange(revent,begin,end) or self.IsInRange(revent,begin,end):
                        event_copy = copy.deepcopy(event)
                        event_copy.DTSTART = revent
                        event_copy.DTEND = revents_end[i-1]
                        found.append(event_copy)
                        bFound = True
        return found
    
    
    def EventsToJSON(self,events):
        result = "[\n"
        for e in events:
            result += "{\n"
            result += "\"uid\":\"" + e.UID.rstrip() + "\",\n"
            result += "\"summary\":\"" + e.SUMMARY.rstrip() + "\",\n"
            result += "\"start\":\"" + str(e.DTSTART.timestamp()) + "\",\n"
            result += "\"end\":\"" + str(e.DTEND.timestamp()) + "\"\n"
            result += "},"

        result = result[:-1]
        result += "\n]"

        return result

    