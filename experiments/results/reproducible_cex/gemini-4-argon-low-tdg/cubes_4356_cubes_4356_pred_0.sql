-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Ties for maximum count (Z_Loc and A_Loc have 3, M_Loc and B_Loc have 1).
-- Tests ORDER BY (Z_Loc vs A_Loc), DISTINCT (multiple losers M_Loc, B_Loc), and tie handling (no LIMIT 1).
INSERT INTO "member" ("Member_ID", "Name", "Nationality", "Role") VALUES ('1', 'Alice', 'USA', 'Violin');
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (1.0, '2023-01-01', 'HostA', 'Z_Loc', 100);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (2.0, '2023-01-02', 'HostB', 'Z_Loc', 200);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (3.0, '2023-01-03', 'HostC', 'Z_Loc', 150);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (4.0, '2023-01-04', 'HostA', 'A_Loc', 50);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (5.0, '2023-01-05', 'HostB', 'A_Loc', 60);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (6.0, '2023-01-06', 'HostC', 'A_Loc', 70);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (7.0, '2023-01-07', 'HostD', 'M_Loc', 500);
INSERT INTO "performance" ("Performance_ID", "Date", "Host", "Location", "Attendance") VALUES (8.0, '2023-01-08', 'HostE', 'B_Loc', 400);
INSERT INTO "member_attendance" ("Member_ID", "Performance_ID", "Num_of_Pieces") VALUES ('1', 1.0, 2);
INSERT INTO "member_attendance" ("Member_ID", "Performance_ID", "Num_of_Pieces") VALUES ('1', 4.0, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT location_other AS LOCATION FROM (SELECT LHS.location AS LOCATION, LHS.n AS n, LHS.maxn AS maxn, RHS.location AS location_other, RHS.n AS n_other, RHS.maxn AS maxn_other FROM (SELECT LOCATION, n, MAX(n) OVER () AS maxn FROM (SELECT LOCATION, COUNT(*) AS n FROM performance GROUP BY LOCATION)) AS LHS CROSS JOIN (SELECT LOCATION, n, MAX(n) OVER () AS maxn FROM (SELECT LOCATION, COUNT(*) AS n FROM performance GROUP BY LOCATION)) AS RHS) WHERE (n < maxn AND maxn <= n_other) ORDER BY LOCATION;

/*
Gold Result:
('A_Loc',)
('Z_Loc',)
*/

-- Prediction Query
SELECT LOCATION FROM performance GROUP BY LOCATION ORDER BY COUNT(*) DESC, LOCATION NULLS LAST LIMIT 1;

/*
Prediction Result:
('A_Loc',)
*/