-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (1, 'Zack', 45, 'USA', 20);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (2, 'Alice', 50, 'UK', 25);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (10, 'Bob', 60, 'France', 35);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (20, 'Charlie', 55, 'Germany', 30);
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (101, 10, 'Orch A', 'Rec 1', 1990.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (102, 20, 'Orch B', 'Rec 2', 1995.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (103, 20, 'Orch C', 'Rec 3', 2000.0, 'Vinyl');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.conductor_id AS conductor_id, LHS.name AS name, LHS.age AS age, LHS.nationality AS nationality, LHS.year_of_work AS year_of_work, RHS.conductor_id AS conductor_id_other FROM conductor AS LHS INNER JOIN (SELECT conductor_id, COUNT(*) AS n FROM orchestra GROUP BY conductor_id) AS RHS ON (LHS.conductor_id = RHS.n)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT T1.Name FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID GROUP BY T2.Conductor_ID ORDER BY COUNT(*) DESC, T1.Name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Charlie',)
*/