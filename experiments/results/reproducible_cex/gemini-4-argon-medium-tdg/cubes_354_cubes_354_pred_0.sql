-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs LEFT/RIGHT/FULL JOIN and extraneous joins with performance/show tables
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (1, 'John Williams', 90, 'USA', 60);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (2, 'Hans Zimmer', 65, 'Germany', 40);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (3, 'Ennio Morricone', 91, 'Italy', 70);
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (10, 1, 'Boston Pops', 'Sony', 1885.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (20, NULL, 'Orphan Orchestra', 'Decca', 1990.0, 'Vinyl');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (30, 2, 'Hollywood Bowl', 'Warner', 1929.0, 'CD');
INSERT INTO performance (Performance_ID, Orchestra_ID, Type, Date, "Official_ratings_(millions)", Weekly_rank, Share) VALUES (100, 10, 'Live', '2020-01-01', 5.5, '1', '10%');
INSERT INTO performance (Performance_ID, Orchestra_ID, Type, Date, "Official_ratings_(millions)", Weekly_rank, Share) VALUES (101, 10, 'Encore', '2020-01-02', 6.0, '2', '12%');
INSERT INTO show (Performance_ID, Show_ID, If_first_show, Result, Attendance) VALUES (100, 1000, 1, 'Success', 5000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, orchestra FROM (SELECT LHS.orchestra_id AS orchestra_id, LHS.orchestra AS orchestra, LHS.conductor_id AS conductor_id, LHS.record_company AS record_company, LHS.year_of_founded AS year_of_founded, LHS.major_record_format AS major_record_format, RHS.name AS name, RHS.age AS age, RHS.nationality AS nationality, RHS.year_of_work AS year_of_work FROM orchestra AS LHS INNER JOIN conductor AS RHS ON (LHS.conductor_id = RHS.conductor_id)) ORDER BY name, orchestra NULLS LAST;

/*
Gold Result:
('Hans Zimmer', 'Hollywood Bowl')
('John Williams', 'Boston Pops')
*/

-- Prediction Query
SELECT T1.Name, T2.Orchestra FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID;

/*
Prediction Result:
('John Williams', 'Boston Pops')
('Hans Zimmer', 'Hollywood Bowl')
*/