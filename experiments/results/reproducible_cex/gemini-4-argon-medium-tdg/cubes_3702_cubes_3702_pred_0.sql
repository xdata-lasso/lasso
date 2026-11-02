-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties for maximum years_working with multiple different nationalities,
-- ordering (DESC vs ASC, unsorted), DISTINCT (duplicate nationalities at max),
-- and joins with news_report (some max journalists have reports, some do not).
INSERT INTO "event" ("Event_ID", "Date", "Venue", "Name", "Event_Attendance") VALUES (1, '2023-05-01', 'Main Hall', 'Tech Conf', 500);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (1, 'Alice', 'USA', '45', 20);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (2, 'Bob', 'Canada', '50', 20);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (3, 'Charlie', 'USA', '39', 20);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (4, 'David', 'UK', '30', 10);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (5, 'Eve', 'Australia', '25', 5);
INSERT INTO "news_report" ("journalist_ID", "Event_ID", "Work_Type") VALUES (1, 1, 'Host');
INSERT INTO "news_report" ("journalist_ID", "Event_ID", "Work_Type") VALUES (4, 1, 'Reporter');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT nationality_other AS nationality FROM (SELECT LHS.journalist_id AS journalist_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, LHS.years_working AS years_working, RHS.journalist_id AS journalist_id_other, RHS.name AS name_other, RHS.nationality AS nationality_other, RHS.age AS age_other, RHS.years_working AS years_working_other FROM (SELECT journalist_id, name, nationality, age, MAX(years_working) OVER () AS years_working FROM journalist) AS LHS CROSS JOIN journalist AS RHS) WHERE (years_working <= years_working_other) ORDER BY nationality;

/*
Gold Result:
('Canada',)
('USA',)
*/

-- Prediction Query
SELECT Nationality FROM journalist ORDER BY Years_working DESC, journalist.journalist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('USA',)
*/