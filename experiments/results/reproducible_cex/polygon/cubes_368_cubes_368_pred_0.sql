-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (1, '31', 23, '24', 25);
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (16, NULL, 28, '29', 30);
INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (15, NULL, '1', '1', 1, '1');
INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (14, 16, '34', '35', 36, '37');
INSERT INTO "performance" ("performance_id", "orchestra_id", "type", "date", "official_ratings_(millions)", "weekly_rank", "share") VALUES (18, 14, '1', '1', 1, '1', '1');
INSERT INTO "performance" ("performance_id", "orchestra_id", "type", "date", "official_ratings_(millions)", "weekly_rank", "share") VALUES (17, 14, '1', '1', 1, '1', '1');
INSERT INTO "show" ("performance_id", "show_id", "if_first_show", "result", "attendance") VALUES (17, 1, 1, '1', 1);
INSERT INTO "show" ("performance_id", "show_id", "if_first_show", "result", "attendance") VALUES (18, 1, 1, '1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.conductor_id AS conductor_id, LHS.name AS name, LHS.age AS age, LHS.nationality AS nationality, LHS.year_of_work AS year_of_work, RHS.conductor_id AS conductor_id_other FROM conductor AS LHS INNER JOIN (SELECT conductor_id, COUNT(*) AS n FROM orchestra GROUP BY conductor_id) AS RHS ON (LHS.conductor_id = RHS.n)) ORDER BY name;

/*
Gold Result:
('31',)
*/

-- Prediction Query
SELECT T1.Name FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID GROUP BY T2.Conductor_ID ORDER BY COUNT(*) DESC, T1.Name NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/