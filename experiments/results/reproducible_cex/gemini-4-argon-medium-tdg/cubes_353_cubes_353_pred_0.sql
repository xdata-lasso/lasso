-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests the secondary tie-breaker: ORDER BY age DESC, conductor_id ASC (default).
-- Two conductors share the maximum age; the one with the smaller Conductor_ID must be returned.
-- Also includes a younger conductor with a larger Year_of_Work to kill mutants ordering by Year_of_Work instead of Age.
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (10, 'Herbert von Karajan', 75, 'Austria', 40);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (5, 'Leonard Bernstein', 75, 'USA', 35);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (1, 'Young Prodigy', 50, 'UK', 45);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM conductor ORDER BY age DESC, conductor.conductor_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Leonard Bernstein',)
*/

-- Prediction Query
SELECT Name FROM conductor ORDER BY Year_of_Work DESC, conductor.conductor_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Young Prodigy',)
*/