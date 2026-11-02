-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (1, 'Charlie', 60, 'USA', 15);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (2, 'Alice', 50, 'UK', 20);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (3, 'Bob', 70, 'France', 10);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (4, 'David', 40, 'Germany', 25);
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (10, 1, 'Symphony One', 'Decca', 1950.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (20, 1, 'Symphony Two', 'Sony', 1965.0, 'Vinyl');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (30, 2, 'Philharmonic', 'EMI', 1980.0, 'CD');
INSERT INTO performance (Performance_ID, Orchestra_ID, Type, Date, "Official_ratings_(millions)", Weekly_rank, Share) VALUES (100, 10, 'Solo', '2020-05-01', 5.5, '1', '12%');
INSERT INTO performance (Performance_ID, Orchestra_ID, Type, Date, "Official_ratings_(millions)", Weekly_rank, Share) VALUES (200, 10, 'Gala', '2020-06-01', 3.2, '4', '8%');
INSERT INTO show (Performance_ID, Show_ID, If_first_show, Result, Attendance) VALUES (100, 1000, 1, 'Success', 1500.0);
INSERT INTO show (Performance_ID, Show_ID, If_first_show, Result, Attendance) VALUES (100, 1001, 0, 'Success', 1200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM conductor ORDER BY name, conductor.conductor_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
('David',)
*/

-- Prediction Query
SELECT Name FROM conductor ORDER BY Age ASC, conductor.conductor_id NULLS LAST;

/*
Prediction Result:
('David',)
('Alice',)
('Charlie',)
('Bob',)
*/