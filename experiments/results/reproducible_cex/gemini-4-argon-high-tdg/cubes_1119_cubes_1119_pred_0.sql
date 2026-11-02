-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (101, '2023-05-01', 'Main Stadium', 'Spring Gala', 5000);
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (102, '2023-06-15', 'City Hall', 'Tech Summit', 1200);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (1, 'Alice', 'Zambia', '25', 2);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (2, 'Bob', 'Zambia', '40', 99);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (3, 'Carlos', 'Argentina', '50', 3);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (4, 'Diana', 'Argentina', '35', 3);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (5, 'Elena', 'Argentina', '28', 4);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (6, 'Frank', 'Canada', '30', 7);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (7, 'Grace', 'Canada', '31', 100);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (8, 'Hans', 'Germany', '45', 9);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (9, 'Pierre', 'France', '45', 8);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (10, 'Ken', 'Japan', '29', 50);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (11, 'Ken', 'Japan', '29', 50);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (20, 'Liam', 'Ireland', '33', 19);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (21, 'Mia', 'Ireland', '34', 22);
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (1, 101, 'Photography');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (3, 102, 'Interview');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (8, 101, 'Broadcast');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT nationality FROM (SELECT LHS.journalist_id AS journalist_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, LHS.years_working AS years_working, RHS.name AS name_other, RHS.age AS age_other, RHS.years_working AS years_working_other FROM journalist AS LHS INNER JOIN journalist AS RHS ON (LHS.years_working = RHS.journalist_id AND LHS.nationality = RHS.nationality)) ORDER BY nationality;

/*
Gold Result:
('Argentina',)
('Canada',)
('Zambia',)
*/

-- Prediction Query
SELECT Nationality FROM journalist ORDER BY Years_working DESC, journalist.journalist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Canada',)
*/