-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Date, tie-breaking by Performance_ID, and anti-correlated column values (Host, Location, Attendance) to kill wrong ORDER BY columns or DESC mutants.
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (10.0, '2023-05-01', 'Zeta', 'Venue A', 500);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (2.0, '2023-05-01', 'Alpha', 'Venue Z', 1000);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (5.0, '2023-01-15', 'Beta', 'Venue M', 800);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (1.0, '2023-09-10', 'Gamma', 'Venue B', 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, LOCATION FROM performance ORDER BY date, performance.performance_id NULLS LAST;

/*
Gold Result:
('2023-01-15', 'Venue M')
('2023-05-01', 'Venue Z')
('2023-05-01', 'Venue A')
('2023-09-10', 'Venue B')
*/

-- Prediction Query
SELECT Date, LOCATION FROM performance;

/*
Prediction Result:
('2023-05-01', 'Venue A')
('2023-05-01', 'Venue Z')
('2023-01-15', 'Venue M')
('2023-09-10', 'Venue B')
*/