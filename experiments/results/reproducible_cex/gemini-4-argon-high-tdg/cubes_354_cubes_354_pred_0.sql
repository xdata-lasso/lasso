-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (1, 'charlie', 50, 'UK', 20);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (2, 'alice', 45, 'USA', 15);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (3, 'bob', 60, 'Germany', 35);
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (1, 2, 'zeta philharmonic', 'Sony', 1950.0, 'CD');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (2, 1, 'beta symphony', 'Decca', 1920.0, 'LP');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (3, 2, 'alpha orchestra', 'EMI', 1980.0, 'DVD');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (4, NULL, 'unconducted ensemble', 'Naxos', 2000.0, 'CD');
INSERT INTO "performance" ("Performance_ID", "Orchestra_ID", "Type", "Date", "Official_ratings_(millions)", "Weekly_rank", "Share") VALUES (10, 1, ' Gala', '2020-01-01', 5.5, '1', '12%');
INSERT INTO "performance" ("Performance_ID", "Orchestra_ID", "Type", "Date", "Official_ratings_(millions)", "Weekly_rank", "Share") VALUES (11, 1, 'Concert', '2020-02-01', 6.2, '2', '15%');
INSERT INTO "performance" ("Performance_ID", "Orchestra_ID", "Type", "Date", "Official_ratings_(millions)", "Weekly_rank", "Share") VALUES (12, 3, 'Festival', '2020-03-01', 4.0, '5', '9%');
INSERT INTO "show" ("Performance_ID", "Show_ID", "If_first_show", "Result", "Attendance") VALUES (10, 100, 1, 'Success', 1500.0);
INSERT INTO "show" ("Performance_ID", "Show_ID", "If_first_show", "Result", "Attendance") VALUES (10, 101, 0, 'Success', 1200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, orchestra FROM (SELECT LHS.orchestra_id AS orchestra_id, LHS.orchestra AS orchestra, LHS.conductor_id AS conductor_id, LHS.record_company AS record_company, LHS.year_of_founded AS year_of_founded, LHS.major_record_format AS major_record_format, RHS.name AS name, RHS.age AS age, RHS.nationality AS nationality, RHS.year_of_work AS year_of_work FROM orchestra AS LHS INNER JOIN conductor AS RHS ON (LHS.conductor_id = RHS.conductor_id)) ORDER BY name, orchestra NULLS LAST;

/*
Gold Result:
('alice', 'alpha orchestra')
('alice', 'zeta philharmonic')
('charlie', 'beta symphony')
*/

-- Prediction Query
SELECT T1.Name, T2.Orchestra FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID;

/*
Prediction Result:
('alice', 'zeta philharmonic')
('charlie', 'beta symphony')
('alice', 'alpha orchestra')
*/