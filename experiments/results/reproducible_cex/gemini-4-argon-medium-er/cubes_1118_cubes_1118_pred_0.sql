-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (1, '2023-01-01', 'Venue A', 'Event A', 10);
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (2, '2023-01-02', 'Venue B', 'Event B', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, name, venue FROM event ORDER BY date, event.event_id NULLS LAST;

/*
Gold Result:
('2023-01-01', 'Event A', 'Venue A')
('2023-01-02', 'Event B', 'Venue B')
*/

-- Prediction Query
SELECT Date, Name, venue FROM event ORDER BY Event_Attendance DESC, event.event_id NULLS LAST;

/*
Prediction Result:
('2023-01-02', 'Event B', 'Venue B')
('2023-01-01', 'Event A', 'Venue A')
*/