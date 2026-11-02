-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (1, 'Leonard Bernstein', 72, 'USA', 45);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (2, 'Herbert von Karajan', 81, 'Austria', 60);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (3, 'Georg Solti', 84, 'Hungary', 55);
INSERT INTO conductor (Conductor_ID, Name, Age, Nationality, Year_of_Work) VALUES (4, 'Claudio Abbado', 80, 'Italy', 50);
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (1, 1, 'New York Philharmonic', 'Columbia', 1960.0, 'Vinyl');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (2, 2, 'Berlin Philharmonic', 'Deutsche Grammophon', 1970.0, 'DVD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (3, 3, 'Chicago Symphony', 'Decca', 1990.0, 'CD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (4, 4, 'London Symphony', 'EMI', 1950.0, 'LP');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (5, 2, 'Vienna Philharmonic', 'Decca', 1961.0, 'Vinyl');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (6, 3, 'Boston Symphony', 'Sony', 1962.0, 'Vinyl');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (7, 1, 'Cleveland Orchestra', 'Sony', 1971.0, 'DVD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (8, 4, 'Royal Concertgebouw', 'Philips', 1972.0, 'DVD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (9, 3, 'Philadelphia Orchestra', 'Columbia', 1973.0, 'DVD');
INSERT INTO orchestra (Orchestra_ID, Conductor_ID, Orchestra, Record_Company, Year_of_Founded, Major_Record_Format) VALUES (10, 4, 'La Scala Orchestra', 'EMI', 1991.0, 'CD');
INSERT INTO performance (Performance_ID, Orchestra_ID, Type, Date, "Official_ratings_(millions)", Weekly_rank, Share) VALUES (1, 1, 'Classical', '2020-01-10', 5.2, '1', '12%');
INSERT INTO performance (Performance_ID, Orchestra_ID, Type, Date, "Official_ratings_(millions)", Weekly_rank, Share) VALUES (2, 1, 'Gala', '2020-02-15', 6.1, '2', '15%');
INSERT INTO performance (Performance_ID, Orchestra_ID, Type, Date, "Official_ratings_(millions)", Weekly_rank, Share) VALUES (3, 2, 'Opera', '2020-03-20', 4.0, '5', '9%');
INSERT INTO performance (Performance_ID, Orchestra_ID, Type, Date, "Official_ratings_(millions)", Weekly_rank, Share) VALUES (4, 3, 'Symphony', '2020-04-25', 3.5, '8', '7%');
INSERT INTO show (Performance_ID, Show_ID, If_first_show, Result, Attendance) VALUES (1, 101, 1, 'Success', 2500.0);
INSERT INTO show (Performance_ID, Show_ID, If_first_show, Result, Attendance) VALUES (2, 102, 0, 'Success', 2800.0);
INSERT INTO show (Performance_ID, Show_ID, If_first_show, Result, Attendance) VALUES (3, 103, 1, 'Average', 1900.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major_record_format FROM (SELECT major_record_format, COUNT(*) AS n FROM orchestra GROUP BY major_record_format) ORDER BY major_record_format;

/*
Gold Result:
('CD',)
('DVD',)
('LP',)
('Vinyl',)
*/

-- Prediction Query
SELECT Major_Record_Format FROM orchestra GROUP BY Major_Record_Format ORDER BY COUNT(*) ASC, Major_Record_Format NULLS LAST;

/*
Prediction Result:
('LP',)
('CD',)
('Vinyl',)
('DVD',)
*/