-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "member" ("Member_ID", "Name", "Nationality", "Role") VALUES ('M1', 'Alice Smith', 'USA', 'Violin');
INSERT INTO "member" ("Member_ID", "Name", "Nationality", "Role") VALUES ('M2', 'Bob Jones', 'UK', 'Cello');
INSERT INTO "member" ("Member_ID", "Name", "Nationality", "Role") VALUES ('M3', 'Charlie Kim', 'Canada', 'Flute');
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (10.0, '2023-05-01', 'Zeta Orchestra', 'Hall A', 500);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (20.0, '2023-01-15', 'Alpha Symphony', 'Hall D', 1200);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (30.0, '2023-08-20', 'Beta Ensemble', 'Hall B', 300);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (5.0, '2023-03-10', 'Alpha Symphony', 'Hall C', 800);
INSERT INTO "member_attendance" ("Member_ID", "Performance_ID", "Num_of_Pieces") VALUES ('M1', 10.0, 3);
INSERT INTO "member_attendance" ("Member_ID", "Performance_ID", "Num_of_Pieces") VALUES ('M2', 10.0, 5);
INSERT INTO "member_attendance" ("Member_ID", "Performance_ID", "Num_of_Pieces") VALUES ('M3', 20.0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT HOST FROM performance ORDER BY HOST, performance.performance_id NULLS LAST;

/*
Gold Result:
('Alpha Symphony',)
('Alpha Symphony',)
('Beta Ensemble',)
('Zeta Orchestra',)
*/

-- Prediction Query
SELECT HOST FROM performance ORDER BY Attendance ASC, performance.performance_id NULLS LAST;

/*
Prediction Result:
('Beta Ensemble',)
('Zeta Orchestra',)
('Alpha Symphony',)
('Alpha Symphony',)
*/