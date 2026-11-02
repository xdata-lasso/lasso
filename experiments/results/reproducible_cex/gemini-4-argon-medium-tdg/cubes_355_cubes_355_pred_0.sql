-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (1, 'Mallory', 42, 'France', 12);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (2, 'Aaron', 38, 'Germany', 8);
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (1, 1, 'Philharmonic 1', 'BMG', 2009.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (2, 2, 'Philharmonic 2', 'Sony', 2009.0, 'CD');
INSERT INTO performance (Performance_ID, Orchestra_ID, Type, Date, "Official_ratings_(millions)", Weekly_rank, Share) VALUES (1, 1, 'Live', '2020-01-01', 5.5, '1', '10%');
INSERT INTO show (Performance_ID, Show_ID, If_first_show, Result, Attendance) VALUES (1, 1, 1, 'Success', 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.conductor_id AS conductor_id, LHS.name AS name, LHS.age AS age, LHS.nationality AS nationality, LHS.year_of_work AS year_of_work, RHS.orchestra_id AS orchestra_id, RHS.orchestra AS orchestra, RHS.record_company AS record_company, RHS.year_of_founded AS year_of_founded, RHS.major_record_format AS major_record_format FROM conductor AS LHS INNER JOIN (SELECT * FROM orchestra WHERE (year_of_founded > 2008.0)) AS RHS ON (LHS.conductor_id = RHS.conductor_id)) ORDER BY name;

/*
Gold Result:
('Aaron',)
('Mallory',)
*/

-- Prediction Query
SELECT T1.Name FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID WHERE Year_of_Founded > 2008;

/*
Prediction Result:
('Mallory',)
('Aaron',)
*/