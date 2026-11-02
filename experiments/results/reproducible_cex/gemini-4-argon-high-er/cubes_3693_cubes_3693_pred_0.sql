-- Schema DDL
CREATE TABLE "event" ("Event_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT, "Event_Attendance" INTEGER);

CREATE TABLE "journalist" ("journalist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT, "Years_working" INTEGER);

CREATE TABLE "news_report" ("journalist_ID" INTEGER, "Event_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("journalist_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("Event_ID"), FOREIGN KEY ("journalist_ID") REFERENCES "journalist" ("journalist_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO journalist (journalist_ID, Name, Nationality, Age, Years_working) VALUES (1, 'Alice', 'USA', '30', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT nationality_other AS nationality FROM (SELECT LHS.age AS age, LHS.nationality AS nationality, LHS.maxn AS maxn, RHS.age AS age_other, RHS.nationality AS nationality_other, RHS.maxn AS maxn_other FROM (SELECT age, nationality, MAX(n) AS maxn FROM (SELECT age, nationality, COUNT(*) AS n FROM journalist GROUP BY age, nationality) GROUP BY age, nationality) AS LHS CROSS JOIN (SELECT age, nationality, MAX(n) AS maxn FROM (SELECT age, nationality, COUNT(*) AS n FROM journalist GROUP BY age, nationality) GROUP BY age, nationality) AS RHS) WHERE (maxn < maxn_other) ORDER BY nationality;

/*
Gold Result:
*/

-- Prediction Query
SELECT Nationality FROM journalist GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
('USA',)
*/