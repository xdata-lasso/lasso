-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (1, 'Alice', 'USA', '30', 10);
INSERT INTO "journalist" ("journalist_ID", "Name", "Nationality", "Age", "Years_working") VALUES (2, 'Bob', 'UK', '40', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT nationality_other AS nationality FROM (SELECT LHS.journalist_id AS journalist_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, LHS.years_working AS years_working, RHS.journalist_id AS journalist_id_other, RHS.name AS name_other, RHS.nationality AS nationality_other, RHS.age AS age_other, RHS.years_working AS years_working_other FROM (SELECT journalist_id, name, nationality, age, MAX(years_working) OVER () AS years_working FROM journalist) AS LHS CROSS JOIN journalist AS RHS) WHERE (years_working <= years_working_other) ORDER BY nationality;

/*
Gold Result:
('UK',)
('USA',)
*/

-- Prediction Query
SELECT Nationality FROM journalist ORDER BY Years_working DESC, journalist.journalist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('USA',)
*/