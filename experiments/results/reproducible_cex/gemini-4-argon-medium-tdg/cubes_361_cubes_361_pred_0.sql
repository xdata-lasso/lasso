-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering, duplicates (kills DISTINCT/GROUP BY), and NULLS in record_company and Conductor_ID (kills INNER JOIN with conductor).
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (1, 'John Williams', 88, 'USA', 60);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (2, 'Hans Zimmer', 63, 'Germany', 40);
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (10, 1, 'Boston Pops', 'Sony', 1885.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (20, 1, 'London Symphony', 'Decca', 1904.0, 'Vinyl');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (5, 2, 'Vienna Phil', 'Decca', 1842.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (30, NULL, 'Indie Orch', 'Alpha', 2000.0, 'Digital');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (40, 2, 'Unknown Orch', NULL, 2010.0, 'CD');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT record_company FROM orchestra ORDER BY record_company, orchestra.orchestra_id NULLS LAST;

/*
Gold Result:
(None,)
('Alpha',)
('Decca',)
('Decca',)
('Sony',)
*/

-- Prediction Query
SELECT Record_Company FROM orchestra ORDER BY Year_of_Founded DESC, orchestra.orchestra_id NULLS LAST;

/*
Prediction Result:
(None,)
('Alpha',)
('Decca',)
('Sony',)
('Decca',)
*/