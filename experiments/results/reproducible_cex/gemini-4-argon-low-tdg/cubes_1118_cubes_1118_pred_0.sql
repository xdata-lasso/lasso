-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (1, '2023-12-01', 'Stadium A', 'Gala', 500);
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (2, '2023-01-15', 'Arena B', 'Summit', 1200);
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (3, '2023-06-20', 'Hall C', 'Expo', 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, name, venue FROM event ORDER BY date, event.event_id NULLS LAST;

/*
Gold Result:
('2023-01-15', 'Summit', 'Arena B')
('2023-06-20', 'Expo', 'Hall C')
('2023-12-01', 'Gala', 'Stadium A')
*/

-- Prediction Query
SELECT Date, Name, venue FROM event ORDER BY Event_Attendance DESC, event.event_id NULLS LAST;

/*
Prediction Result:
('2023-01-15', 'Summit', 'Arena B')
('2023-12-01', 'Gala', 'Stadium A')
('2023-06-20', 'Expo', 'Hall C')
*/