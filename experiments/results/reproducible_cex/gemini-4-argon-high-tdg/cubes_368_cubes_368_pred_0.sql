-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (1, 'Zack', 35, 'France', 10);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (2, 'Adam', 50, 'USA', 20);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (3, 'Mike', 25, 'Brazil', 30);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (10, 'Ten_Cond', 40, 'UK', 15);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (20, 'Twenty_Cond', 45, 'Germany', 25);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (30, 'Thirty_Cond', 60, 'Italy', 35);
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (101, 10, 'Orch_A', 'Decca', 1950.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (102, 20, 'Orch_B1', 'Sony', 1960.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (103, 20, 'Orch_B2', 'EMI', 1965.0, 'Vinyl');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (104, 30, 'Orch_C1', 'BMG', 1970.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (105, 30, 'Orch_C2', 'Naxos', 1975.0, 'LP');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (106, 30, 'Orch_C3', 'DG', 1980.0, 'CD');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.conductor_id AS conductor_id, LHS.name AS name, LHS.age AS age, LHS.nationality AS nationality, LHS.year_of_work AS year_of_work, RHS.conductor_id AS conductor_id_other FROM conductor AS LHS INNER JOIN (SELECT conductor_id, COUNT(*) AS n FROM orchestra GROUP BY conductor_id) AS RHS ON (LHS.conductor_id = RHS.n)) ORDER BY name;

/*
Gold Result:
('Adam',)
('Mike',)
('Zack',)
*/

-- Prediction Query
SELECT T1.Name FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID GROUP BY T2.Conductor_ID ORDER BY COUNT(*) DESC, T1.Name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Thirty_Cond',)
*/