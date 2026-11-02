-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO member (Member_ID, Name, Nationality, Role) VALUES ('1', 'Bob', 'UK', 'Cello');
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (1.0, '2023-02-01', 'H1', 'Z_Arena', 100);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (2.0, '2023-02-02', 'H1', 'Z_Arena', 100);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (3.0, '2023-02-03', 'H1', 'Z_Arena', 100);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (4.0, '2023-02-04', 'H2', 'M_Stage', 100);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (5.0, '2023-02-05', 'H3', 'A_Hall', 100);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (6.0, '2023-02-06', 'H3', 'A_Hall', 100);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (7.0, '2023-02-07', 'H3', 'A_Hall', 100);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (8.0, '2023-02-08', 'H4', 'B_Club', 100);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (9.0, '2023-02-09', 'H4', 'B_Club', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT location_other AS LOCATION FROM (SELECT LHS.location AS LOCATION, LHS.n AS n, LHS.maxn AS maxn, RHS.location AS location_other, RHS.n AS n_other, RHS.maxn AS maxn_other FROM (SELECT LOCATION, n, MAX(n) OVER () AS maxn FROM (SELECT LOCATION, COUNT(*) AS n FROM performance GROUP BY LOCATION)) AS LHS CROSS JOIN (SELECT LOCATION, n, MAX(n) OVER () AS maxn FROM (SELECT LOCATION, COUNT(*) AS n FROM performance GROUP BY LOCATION)) AS RHS) WHERE (n < maxn AND maxn <= n_other) ORDER BY LOCATION;

/*
Gold Result:
('A_Hall',)
('Z_Arena',)
*/

-- Prediction Query
SELECT LOCATION FROM performance GROUP BY LOCATION ORDER BY COUNT(*) DESC, LOCATION NULLS LAST LIMIT 1;

/*
Prediction Result:
('A_Hall',)
*/