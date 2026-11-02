-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (1, '2023-01-10', 'Arena A', 'Opening Gala', 500);
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (2, '2023-02-15', 'Hall B', 'Tech Summit', 1200);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (1, 'Eve', 'Denmark', '25', 3);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (2, 'Frank', 'Egypt', '1', 10);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (4, 'Bob', 'Canada', '7', 15);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (5, 'Zack', 'Chile', '4', 1);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (6, 'Charlie', 'Argentina', '5', 2);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (7, 'Alice', 'Brazil', '6', 11);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (8, 'David', 'Canada', '8', 18);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (12, 'Grace', 'France', '40', 6);
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (6, 1, 'Reporter');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (6, 2, 'Editor');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (1, 1, 'Host');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT nationality FROM journalist WHERE (years_working > 10 OR years_working < 3) ORDER BY nationality;

/*
Gold Result:
('Argentina',)
('Brazil',)
('Canada',)
('Chile',)
*/

-- Prediction Query
SELECT Nationality FROM journalist WHERE Years_working > 10 INTERSECT SELECT Nationality FROM journalist WHERE Years_working < 3;

/*
Prediction Result:
*/