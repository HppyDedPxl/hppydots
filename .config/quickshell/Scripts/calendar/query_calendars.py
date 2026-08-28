import ics_parser
import ics_calendar
from datetime import datetime
import requests
from zoneinfo import ZoneInfo
import argparse

parser = argparse.ArgumentParser()

parser.add_argument("-l",'--ics_list',nargs="+", help='<Required>', required=True)
parser.add_argument("-t",'--target', help='<Required>', required=True)
parser.add_argument("-b",'--begin', help='<Required>', required=True)
parser.add_argument("-e",'--end', help='<Required>', required=True)

args = parser.parse_args()

cal_links = args.ics_list

calendar = ics_calendar.ICSCalendar()

for ics_uri in cal_links:
    r = requests.get(ics_uri)
    if r.status_code == 200:
        with open("cal.ics","w") as f:
            f.write(r.text)
    else:
        print("Error getting cal link")


    icsparser = ics_parser.ICSParser("cal.ics")
    calendar.AddEvents(icsparser.events)

begin_ts = datetime.fromisoformat(args.begin).replace(tzinfo=ZoneInfo("Europe/Berlin"));
end_ts = datetime.fromisoformat(args.end).replace(tzinfo=ZoneInfo("Europe/Berlin"));

e = calendar.GetEventsInTimeRange(begin_ts,end_ts)

json = calendar.EventsToJSON(e)

with open (args.target, "w") as f:
    f.write(json)

print("finished")