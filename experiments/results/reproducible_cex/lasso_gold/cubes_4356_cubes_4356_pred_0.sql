-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1001.5, 'purpose', 'site', '819 Johnson Course
East William, AK 74064', 1004);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1002.5, 'brother', 'face', '819 Johnson Course
East William, AK 74064', 1015.0);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1003.5, 'ago', 'election', '819 Johnson Course
East William, AK 74064', 1026.0);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1007.5, 'decide', 'science', '26542 Susan Junction Apt. 161
Melanieview, AS 06196', 1010);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1008.5, 'sense', 'offer', '26542 Susan Junction Apt. 161
Melanieview, AS 06196', 1021.0);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1009.5, 'rate', 'kind', '26542 Susan Junction Apt. 161
Melanieview, AS 06196', 1032.0);
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
('26542 Susan Junction Apt. 161\nMelanieview, AS 06196',)
*/