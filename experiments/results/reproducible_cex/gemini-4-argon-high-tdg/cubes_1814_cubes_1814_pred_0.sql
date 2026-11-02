-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "member" ("Member_ID", "Name", "Nationality", "Role") VALUES ('1', 'Alice Smith', 'USA', 'Violin');
INSERT INTO "member" ("Member_ID", "Name", "Nationality", "Role") VALUES ('2', 'Bob Tremblay', 'Canada', 'Cello');
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (1, '2023-04-10', 'Boston Symphony', 'TD Garden', 3000);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (2, '2023-01-15', 'Montreal Guild', 'Bell Centre', 500);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (3, '2023-02-20', 'NY Philharmonic', 'Madison Square Garden', 2000);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (4, '2023-03-05', 'TD Garden', 'Symphony Hall', 1200);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (5, '2023-05-12', 'Boston Symphony', 'TD Garden', 1500);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (6, '2023-06-18', 'Montreal Guild', 'Bell Centre', 1500);
INSERT INTO "member_attendance" ("Member_ID", "Performance_ID", "Num_of_Pieces") VALUES (1, 1, 4);
INSERT INTO "member_attendance" ("Member_ID", "Performance_ID", "Num_of_Pieces") VALUES (2, 1, 3);
INSERT INTO "member_attendance" ("Member_ID", "Performance_ID", "Num_of_Pieces") VALUES (1, 3, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "attendance" FROM "performance" WHERE ("location" = 'TD Garden' OR "location" = 'Bell Centre') ORDER BY attendance, performance.performance_id NULLS LAST;

/*
Gold Result:
(500,)
(1500,)
(1500,)
(3000,)
*/

-- Prediction Query
SELECT Attendance FROM performance WHERE LOCATION = 'TD Garden' OR LOCATION = 'Bell Centre';

/*
Prediction Result:
(3000,)
(500,)
(1500,)
(1500,)
*/