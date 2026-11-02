-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (101, '2023-05-10', 'Arena A', 'Tech Summit', 500);
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (102, '2023-06-15', 'Hall B', 'Music Fest', 1200);
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (103, '2023-07-20', 'Stadium C', 'Sports Gala', 3000);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (1, 'Bob', 'USA', '30', 8);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (2, 'Zack', 'Canada', '45', 20);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (3, 'Bob', 'USA', '30', 8);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (4, 'Alice', 'Canada', '25', 3);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (5, 'Charlie', 'USA', '22', 1);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (6, 'Diana', 'Brazil', '38', 12);
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (1, 101, 'Reporter');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (1, 102, 'Host');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (2, 101, 'Photographer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality, age FROM journalist ORDER BY nationality, journalist.journalist_id NULLS LAST;

/*
Gold Result:
('Brazil', '38')
('Canada', '45')
('Canada', '25')
('USA', '30')
('USA', '30')
('USA', '22')
*/

-- Prediction Query
SELECT Nationality, Age FROM journalist;

/*
Prediction Result:
('USA', '30')
('Canada', '45')
('USA', '30')
('Canada', '25')
('USA', '22')
('Brazil', '38')
*/