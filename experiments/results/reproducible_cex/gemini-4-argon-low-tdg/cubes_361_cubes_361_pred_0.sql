-- Schema DDL
CREATE TABLE "conductor" ("Conductor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "Nationality" TEXT, "Year_of_Work" INTEGER);

CREATE TABLE "orchestra" ("Orchestra_ID" INTEGER PRIMARY KEY, "Conductor_ID" INTEGER, "Orchestra" TEXT, "Record_Company" TEXT, "Year_of_Founded" REAL, "Major_Record_Format" TEXT, FOREIGN KEY ("Conductor_ID") REFERENCES "conductor" ("Conductor_ID"));

CREATE TABLE "performance" ("Performance_ID" INTEGER PRIMARY KEY, "Orchestra_ID" INTEGER, "Type" TEXT, "Date" TEXT, "Official_ratings_(millions)" REAL, "Weekly_rank" TEXT, "Share" TEXT, FOREIGN KEY ("Orchestra_ID") REFERENCES "orchestra" ("Orchestra_ID"));

CREATE TABLE "show" ("Performance_ID" INTEGER, "Show_ID" INTEGER, "If_first_show" INTEGER, "Result" TEXT, "Attendance" REAL, FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (counter-ordered to primary key), duplicate values in Record_Company (to kill DISTINCT/GROUP BY mutants), and unnecessary INNER JOINs with conductor or performance (via NULL foreign keys and missing child rows).
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (1, 'John Williams', 90, 'USA', 60);
INSERT INTO "conductor" ("Conductor_ID", "Name", "Age", "Nationality", "Year_of_Work") VALUES (2, 'Hans Zimmer', 65, 'Germany', 40);
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (1, 1, 'Boston Pops', 'Sony', 1885.0, 'CD');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (2, 2, 'London Symphony', 'Decca', 1904.0, 'Vinyl');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (3, 1, 'Vienna Philharmonic', 'Decca', 1842.0, 'CD');
INSERT INTO "orchestra" ("Orchestra_ID", "Conductor_ID", "Orchestra", "Record_Company", "Year_of_Founded", "Major_Record_Format") VALUES (4, NULL, 'Berlin Philharmonic', 'EMI', 1882.0, 'Digital');
INSERT INTO "performance" ("Performance_ID", "Orchestra_ID", "Type", "Date", "Official_ratings_(millions)", "Weekly_rank", "Share") VALUES (1, 1, 'Live', '2023-01-01', 5.5, '1', '20%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT record_company FROM orchestra ORDER BY record_company, orchestra.orchestra_id NULLS LAST;

/*
Gold Result:
('Decca',)
('Decca',)
('EMI',)
('Sony',)
*/

-- Prediction Query
SELECT Record_Company FROM orchestra ORDER BY Year_of_Founded DESC, orchestra.orchestra_id NULLS LAST;

/*
Prediction Result:
('Decca',)
('Sony',)
('EMI',)
('Decca',)
*/