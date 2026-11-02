-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (1, '2023-01-10', 'Arena A', 'Tech Summit', 500);
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (2, '2023-02-15', 'Hall B', 'Sports Gala', 1200);
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (3, '2023-03-20', 'Center C', 'Music Fest', 800);
INSERT INTO event (Event_ID, Date, Venue, Name, Event_Attendance) VALUES (4, '2023-04-25', 'Stadium D', 'Book Fair', 300);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (1, 'John Smith', 'USA', '40', 1);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (2, 'Mike Brown', 'USA', '40', 1);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (3, 'Sarah Davis', 'USA', '40', 1);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (4, 'Alice Roy', 'Canada', '30', 5);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (5, 'Bob Tremblay', 'Canada', '30', 5);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (6, 'Pedro Silva', 'Brazil', '20', 20);
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (6, 1, 'Host');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (6, 2, 'Reporter');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (6, 3, 'Editor');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (6, 4, 'Anchor');
INSERT INTO news_report (journalist_ID, Event_ID, Work_Type) VALUES (4, 1, 'Reporter');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT nationality_other AS nationality FROM (SELECT LHS.age AS age, LHS.nationality AS nationality, LHS.maxn AS maxn, RHS.age AS age_other, RHS.nationality AS nationality_other, RHS.maxn AS maxn_other FROM (SELECT age, nationality, MAX(n) AS maxn FROM (SELECT age, nationality, COUNT(*) AS n FROM journalist GROUP BY age, nationality) GROUP BY age, nationality) AS LHS CROSS JOIN (SELECT age, nationality, MAX(n) AS maxn FROM (SELECT age, nationality, COUNT(*) AS n FROM journalist GROUP BY age, nationality) GROUP BY age, nationality) AS RHS) WHERE (maxn < maxn_other) ORDER BY nationality;

/*
Gold Result:
('Canada',)
('USA',)
*/

-- Prediction Query
SELECT Nationality FROM journalist GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
('USA',)
*/