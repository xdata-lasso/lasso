-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (101, '2023-01-10', 'Arena A', 'World Cup', 50000);
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (102, '2023-02-15', 'Hall B', 'Tech Summit', 1200);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (1, 'Zara', 'UK', '25', 2);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (2, 'Alice', 'USA', '40', 15);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (3, 'Bob', 'Canada', '30', 10);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (4, 'Alice', 'France', '35', 5);
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (1, 101, 'Broadcast');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (1, 102, 'Print');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (2, 101, 'Online');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM journalist ORDER BY name, journalist.journalist_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Zara',)
*/

-- Prediction Query
SELECT Name FROM journalist ORDER BY Years_working ASC, journalist.journalist_id NULLS LAST;

/*
Prediction Result:
('Zara',)
('Alice',)
('Bob',)
('Alice',)
*/