-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (1, 'Alice', 'Germany', '30', 1);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (2, 'Bob', 'Spain', '30', 2);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (3, 'Charlie', 'Spain', '40', 2);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (4, 'David', 'Italy', '35', 5);
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (5, 'Eve', 'Italy', '45', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT nationality FROM (SELECT LHS.journalist_id AS journalist_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, LHS.years_working AS years_working, RHS.name AS name_other, RHS.age AS age_other, RHS.years_working AS years_working_other FROM journalist AS LHS INNER JOIN journalist AS RHS ON (LHS.years_working = RHS.journalist_id AND LHS.nationality = RHS.nationality)) ORDER BY nationality;

/*
Gold Result:
('Germany',)
('Italy',)
('Spain',)
*/

-- Prediction Query
SELECT Nationality FROM journalist ORDER BY Years_working DESC, journalist.journalist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Italy',)
*/