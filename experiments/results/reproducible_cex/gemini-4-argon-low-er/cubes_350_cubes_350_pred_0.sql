-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (1, 'John', 50, 'USA', 20);
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (1, 1, 'Orch1', 'Comp1', 1990, 'B');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (2, 1, 'Orch2', 'Comp2', 1991, 'A');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (3, 1, 'Orch3', 'Comp3', 1992, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major_record_format FROM (SELECT major_record_format, COUNT(*) AS n FROM orchestra GROUP BY major_record_format) ORDER BY major_record_format;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT Major_Record_Format FROM orchestra GROUP BY Major_Record_Format ORDER BY COUNT(*) ASC, Major_Record_Format NULLS LAST;

/*
Prediction Result:
('B',)
('A',)
*/