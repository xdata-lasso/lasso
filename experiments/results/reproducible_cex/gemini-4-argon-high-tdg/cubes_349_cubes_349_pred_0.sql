-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (1, 'Herbert von Karajan', 65, 'Austrian', 35);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (2, 'Leonard Bernstein', 60, 'American', 30);
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (1, 1, 'Orchestra S1', 'Sony', 1950.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (2, 1, 'Orchestra B1', 'BMG', 1960.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (3, 1, 'Orchestra B2', 'BMG', 1965.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (4, 2, 'Orchestra D1', 'Decca', 1940.0, 'Vinyl');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (5, 2, 'Orchestra D2', 'Decca', 1945.0, 'Vinyl');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (6, 2, 'Orchestra D3', 'Decca', 1955.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (7, 2, 'Orchestra D4', 'Decca', 1970.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (8, 1, 'Orchestra A1', 'Apex', 1980.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (9, 2, 'Orchestra A2', 'Apex', 1985.0, 'DVD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (10, 1, 'Orchestra A3', 'Apex', 1990.0, 'CD');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT record_company_other AS record_company FROM (SELECT LHS.record_company AS record_company, LHS.n AS n, RHS.record_company AS record_company_other, RHS.n AS n_other FROM (SELECT record_company, COUNT(*) AS n FROM orchestra GROUP BY record_company) AS LHS CROSS JOIN (SELECT record_company, COUNT(*) AS n FROM orchestra GROUP BY record_company) AS RHS) WHERE (n < n_other) ORDER BY record_company;

/*
Gold Result:
('Apex',)
('BMG',)
('Decca',)
*/

-- Prediction Query
SELECT Record_Company FROM orchestra GROUP BY Record_Company ORDER BY COUNT(*) DESC, Record_Company NULLS LAST LIMIT 1;

/*
Prediction Result:
('Decca',)
*/