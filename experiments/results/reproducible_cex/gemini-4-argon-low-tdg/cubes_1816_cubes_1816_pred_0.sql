-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Date, secondary ordering by Performance_ID (including NULLS LAST), and distinguishes column selection (Date, Location vs Host).
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (10.5, '2023-05-01', 'Host_A', 'Loc_Z', 100);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (2.0, '2023-05-01', 'Host_B', 'Loc_A', 200);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (NULL, '2023-05-01', 'Host_C', 'Loc_M', 150);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (1.0, '2023-01-15', 'Host_D', 'Loc_B', 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, LOCATION FROM performance ORDER BY date, performance.performance_id NULLS LAST;

/*
Gold Result:
('2023-01-15', 'Loc_B')
('2023-05-01', 'Loc_A')
('2023-05-01', 'Loc_Z')
('2023-05-01', 'Loc_M')
*/

-- Prediction Query
SELECT Date, LOCATION FROM performance;

/*
Prediction Result:
('2023-05-01', 'Loc_Z')
('2023-05-01', 'Loc_A')
('2023-05-01', 'Loc_M')
('2023-01-15', 'Loc_B')
*/