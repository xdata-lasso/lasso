-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(event_attendance) OVER () AS avg_event_attendance_, maxevent_attendance AS max_event_attendance_ FROM (SELECT event_id, date, venue, name, event_attendance, MAX(event_attendance) OVER () AS maxevent_attendance FROM event) ORDER BY avg_event_attendance_, max_event_attendance_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(Event_Attendance), MAX(Event_Attendance) FROM event;

/*
Prediction Result:
(None, None)
*/