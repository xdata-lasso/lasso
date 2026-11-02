-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (1, 'Denis Russell Davies', 60, 'USA', 20);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (2, 'Antal Dorati', 70, 'Hungary', 35);
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (1, 1, 'London Symphony Orchestra', 'Naxos', 1904.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (2, 1, 'Boston Symphony Orchestra', 'Sony', 1881.0, 'Vinyl');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (3, 2, 'New York Philharmonic', 'Universal', 1842.0, 'DVD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (4, 2, 'Chicago Symphony Orchestra', 'Naxos', 1891.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (5, 1, 'Berlin Philharmonic', 'Deutsche Grammophon', 1882.0, 'DVD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (6, 2, 'Vienna Philharmonic', 'Decca', 1842.0, 'CD');
INSERT INTO performance (Performance_ID, Orchestra_ID, Type, Date, "Official_ratings_(millions)", Weekly_rank, Share) VALUES (1, 1, 'Solo', '10 June', 5.2, '12', '10%');
INSERT INTO performance (Performance_ID, Orchestra_ID, Type, Date, "Official_ratings_(millions)", Weekly_rank, Share) VALUES (2, 2, 'Audition', '11 June', 6.1, '5', '15%');
INSERT INTO show (Performance_ID, Show_ID, If_first_show, Result, Attendance) VALUES (1, 1, 1, 'T', 1026.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major_record_format FROM (SELECT major_record_format, COUNT(*) AS n FROM orchestra GROUP BY major_record_format) ORDER BY major_record_format;

/*
Gold Result:
('CD',)
('DVD',)
('Vinyl',)
*/

-- Prediction Query
SELECT Major_Record_Format FROM orchestra GROUP BY Major_Record_Format ORDER BY COUNT(*) ASC, Major_Record_Format NULLS LAST;

/*
Prediction Result:
('Vinyl',)
('DVD',)
('CD',)
*/