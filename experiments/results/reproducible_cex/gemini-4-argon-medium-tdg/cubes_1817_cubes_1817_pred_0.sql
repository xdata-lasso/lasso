-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC), duplicates (SELECT vs SELECT DISTINCT), NULL Host handling, and extraneous WHERE/JOIN mutations.
INSERT INTO "member" ("Member_ID", "Name", "Nationality", "Role") VALUES ('1', 'Alice', 'USA', 'Violin');
INSERT INTO "member" ("Member_ID", "Name", "Nationality", "Role") VALUES ('2', 'Bob', 'UK', 'Cello');
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (10.0, '2023-05-01', 'Zeta', 'Hall A', 500);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (20.0, '2023-01-01', 'Alpha', 'Hall B', 100);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (5.0, '2023-09-01', 'Alpha', 'Hall C', 300);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (15.0, '2023-03-01', 'Beta', 'Hall D', 0);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (25.0, '2023-07-01', NULL, 'Hall E', -50);
INSERT INTO "member_attendance" ("Member_ID", "Performance_ID", "Num_of_Pieces") VALUES (1, 10, 3);
INSERT INTO "member_attendance" ("Member_ID", "Performance_ID", "Num_of_Pieces") VALUES (2, 10, 2);
INSERT INTO "member_attendance" ("Member_ID", "Performance_ID", "Num_of_Pieces") VALUES (1, 20, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT HOST FROM performance ORDER BY HOST, performance.performance_id NULLS LAST;

/*
Gold Result:
(None,)
('Alpha',)
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT HOST FROM performance ORDER BY Attendance ASC, performance.performance_id NULLS LAST;

/*
Prediction Result:
(None,)
('Beta',)
('Alpha',)
('Alpha',)
('Zeta',)
*/