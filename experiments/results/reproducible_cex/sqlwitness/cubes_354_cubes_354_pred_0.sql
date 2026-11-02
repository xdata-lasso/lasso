-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO conductor (conductor_id, name, age, nationality, year_of_work) VALUES (1, NULL, NULL, 'default1', NULL), (0, NULL, 0, 'default2', NULL), (2, 'default2', NULL, NULL, 0);
INSERT INTO orchestra (orchestra_id, conductor_id, orchestra, record_company, year_of_founded, major_record_format) VALUES (0, 2, 'default2', 'default2', 1.0, 'default2'), (1, 2, 'default1', 'default1', 0.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, orchestra FROM (SELECT LHS.orchestra_id AS orchestra_id, LHS.orchestra AS orchestra, LHS.conductor_id AS conductor_id, LHS.record_company AS record_company, LHS.year_of_founded AS year_of_founded, LHS.major_record_format AS major_record_format, RHS.name AS name, RHS.age AS age, RHS.nationality AS nationality, RHS.year_of_work AS year_of_work FROM orchestra AS LHS INNER JOIN conductor AS RHS ON (LHS.conductor_id = RHS.conductor_id)) ORDER BY name, orchestra NULLS LAST;

/*
Gold Result:
('default2', 'default1')
('default2', 'default2')
*/

-- Prediction Query
SELECT T1.Name, T2.Orchestra FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID;

/*
Prediction Result:
('default2', 'default2')
('default2', 'default1')
*/