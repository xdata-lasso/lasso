-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "member" ("member_id", "name", "nationality", "role") VALUES ('14', '1', '1', '1');
INSERT INTO "member" ("member_id", "name", "nationality", "role") VALUES ('13', '1', '1', '1');
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (16, '1', '1', NULL, 1);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (15, '1', '1', '17', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT location_other AS LOCATION FROM (SELECT LHS.location AS LOCATION, LHS.n AS n, LHS.maxn AS maxn, RHS.location AS location_other, RHS.n AS n_other, RHS.maxn AS maxn_other FROM (SELECT LOCATION, n, MAX(n) OVER () AS maxn FROM (SELECT LOCATION, COUNT(*) AS n FROM performance GROUP BY LOCATION)) AS LHS CROSS JOIN (SELECT LOCATION, n, MAX(n) OVER () AS maxn FROM (SELECT LOCATION, COUNT(*) AS n FROM performance GROUP BY LOCATION)) AS RHS) WHERE (n < maxn AND maxn <= n_other) ORDER BY LOCATION;

/*
Gold Result:
*/

-- Prediction Query
SELECT LOCATION FROM performance GROUP BY LOCATION ORDER BY COUNT(*) DESC, LOCATION NULLS LAST LIMIT 1;

/*
Prediction Result:
('17',)
*/