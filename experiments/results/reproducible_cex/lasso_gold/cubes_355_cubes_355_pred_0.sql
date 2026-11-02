-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (1084, 'Jose Ramirez', 1085, 'British Indian Ocean Territory (Chagos Archipelago)', 1086);
INSERT INTO "conductor" ("conductor_id", "name", "age", "nationality", "year_of_work") VALUES (1088, 'Jessica Holmes', 1086, 'Russian Federation', 1087);
INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (1087, 1084, 'end', 'Brown Inc', 2009.0, 'per');
INSERT INTO "orchestra" ("orchestra_id", "conductor_id", "orchestra", "record_company", "year_of_founded", "major_record_format") VALUES (1091, 1088, 'program', 'Perez Inc', 2009.0, 'trade');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.conductor_id AS conductor_id, LHS.name AS name, LHS.age AS age, LHS.nationality AS nationality, LHS.year_of_work AS year_of_work, RHS.orchestra_id AS orchestra_id, RHS.orchestra AS orchestra, RHS.record_company AS record_company, RHS.year_of_founded AS year_of_founded, RHS.major_record_format AS major_record_format FROM conductor AS LHS INNER JOIN (SELECT * FROM orchestra WHERE (year_of_founded > 2008.0)) AS RHS ON (LHS.conductor_id = RHS.conductor_id)) ORDER BY name;

/*
Gold Result:
('Jessica Holmes',)
('Jose Ramirez',)
*/

-- Prediction Query
SELECT T1.Name FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID WHERE Year_of_Founded > 2008;

/*
Prediction Result:
('Jose Ramirez',)
('Jessica Holmes',)
*/