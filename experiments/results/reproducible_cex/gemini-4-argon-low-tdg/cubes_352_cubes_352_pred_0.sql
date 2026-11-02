-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ascending order, duplicate names (DISTINCT vs ALL), tie-breaking by Conductor_ID, and spurious JOINs with orchestra/performance/show (unmatched conductors vs multiple orchestras per conductor).
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (3, 'Carlos Kleiber', 45, 'Austrian', 20);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (1, 'Leonard Bernstein', 70, 'American', 45);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (4, 'Leonard Bernstein', 35, 'American', 10);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (2, 'Herbert von Karajan', 80, 'Austrian', 60);
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (10, 1, 'New York Philharmonic', 'Columbia', 1842.0, 'CD');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (11, 1, 'Vienna Philharmonic', 'DG', 1842.0, 'Vinyl');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (12, 2, 'Berlin Philharmonic', 'EMI', 1882.0, 'CD');
INSERT INTO "performance" ("Performance_ID", "Orchestra_ID", "Type", "Date", "Official_ratings_(millions)", "Weekly_rank", "Share") VALUES (100, 10, 'Live', '2020-01-01', 5.5, '1', '12%');
INSERT INTO "performance" ("Performance_ID", "Orchestra_ID", "Type", "Date", "Official_ratings_(millions)", "Weekly_rank", "Share") VALUES (101, 10, 'Broadcast', '2020-01-02', 6.0, '2', '15%');
INSERT INTO "show" ("Performance_ID", "Show_ID", "If_first_show", "Result", "Attendance") VALUES (100, 1000, 1, 'Success', 2500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM conductor ORDER BY name, conductor.conductor_id NULLS LAST;

/*
Gold Result:
('Carlos Kleiber',)
('Herbert von Karajan',)
('Leonard Bernstein',)
('Leonard Bernstein',)
*/

-- Prediction Query
SELECT Name FROM conductor ORDER BY Age ASC, conductor.conductor_id NULLS LAST;

/*
Prediction Result:
('Leonard Bernstein',)
('Carlos Kleiber',)
('Leonard Bernstein',)
('Herbert von Karajan',)
*/