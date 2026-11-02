-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (1.0, '2023-01-01', 'Host A', 'TD Garden', 5000);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (2.0, '2023-01-02', 'Host B', 'Bell Centre', 3000);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (3.0, '2023-01-03', 'Host C', 'Madison Square Garden', 4000);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (4.0, '2023-01-04', 'Host D', 'TD Garden', 3000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "attendance" FROM "performance" WHERE ("location" = 'TD Garden' OR "location" = 'Bell Centre') ORDER BY attendance, performance.performance_id NULLS LAST;

/*
Gold Result:
(3000,)
(3000,)
(5000,)
*/

-- Prediction Query
SELECT Attendance FROM performance WHERE LOCATION = 'TD Garden' OR LOCATION = 'Bell Centre';

/*
Prediction Result:
(5000,)
(3000,)
(3000,)
*/