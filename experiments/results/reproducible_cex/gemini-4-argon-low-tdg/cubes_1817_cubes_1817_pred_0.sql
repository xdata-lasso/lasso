-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (10.5, '2022-10-10', NULL, 'Tokyo', 150);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (NULL, '2022-11-11', NULL, 'Seoul', 250);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (5.5, '2022-12-12', 'Omega Events', 'Sydney', 50);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (20.0, '2023-01-15', 'Gamma Inc', 'Toronto', 0);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (15.0, '2023-01-10', 'Gamma Inc', 'Vancouver', -10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT HOST FROM performance ORDER BY HOST, performance.performance_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('Gamma Inc',)
('Gamma Inc',)
('Omega Events',)
*/

-- Prediction Query
SELECT HOST FROM performance ORDER BY Attendance ASC, performance.performance_id NULLS LAST;

/*
Prediction Result:
('Gamma Inc',)
('Gamma Inc',)
('Omega Events',)
(None,)
(None,)
*/