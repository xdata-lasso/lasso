-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Date ASC, and secondary ordering by Event_ID ASC when Date is tied.
-- Also tests column selection (Date, Name, Venue) and ensures insertion order differs from output order.
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (10, '2023-05-01', 'Stadium A', 'Opening Ceremony', 5000);
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (5, '2023-05-01', 'Arena B', 'Keynote Speech', 1200);
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (1, '2023-06-15', 'Hall C', 'Closing Gala', 800);
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (20, '2023-01-10', 'Center D', 'Pre-Event', 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, name, venue FROM event ORDER BY date, event.event_id NULLS LAST;

/*
Gold Result:
('2023-01-10', 'Pre-Event', 'Center D')
('2023-05-01', 'Keynote Speech', 'Arena B')
('2023-05-01', 'Opening Ceremony', 'Stadium A')
('2023-06-15', 'Closing Gala', 'Hall C')
*/

-- Prediction Query
SELECT Date, Name, venue FROM event ORDER BY Event_Attendance DESC, event.event_id NULLS LAST;

/*
Prediction Result:
('2023-05-01', 'Opening Ceremony', 'Stadium A')
('2023-05-01', 'Keynote Speech', 'Arena B')
('2023-06-15', 'Closing Gala', 'Hall C')
('2023-01-10', 'Pre-Event', 'Center D')
*/