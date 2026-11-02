-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (1, '2023-05-10', 'Arena B', 'Summit Gamma', 300);
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (2, '2021-01-15', 'Hall Z', 'Expo Delta', 50);
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (3, '2022-08-20', 'Center Y', 'Forum Omega', 900);
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (4, '2022-08-20', 'Center A', 'Forum Alpha', 100);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (101, 'Alice Smith', 'USA', '34', 10);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (102, 'Bob Jones', 'UK', '41', 15);
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (101, 1, 'Broadcast');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (102, 1, 'Broadcast');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (101, 3, 'Print');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, name, venue FROM event ORDER BY date, event.event_id NULLS LAST;

/*
Gold Result:
('2021-01-15', 'Expo Delta', 'Hall Z')
('2022-08-20', 'Forum Omega', 'Center Y')
('2022-08-20', 'Forum Alpha', 'Center A')
('2023-05-10', 'Summit Gamma', 'Arena B')
*/

-- Prediction Query
SELECT Date, Name, venue FROM event ORDER BY Event_Attendance DESC, event.event_id NULLS LAST;

/*
Prediction Result:
('2022-08-20', 'Forum Omega', 'Center Y')
('2023-05-10', 'Summit Gamma', 'Arena B')
('2022-08-20', 'Forum Alpha', 'Center A')
('2021-01-15', 'Expo Delta', 'Hall Z')
*/