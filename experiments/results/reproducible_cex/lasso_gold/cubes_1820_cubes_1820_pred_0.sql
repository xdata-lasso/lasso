-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1001.5, 'purpose', 'face', '600 Jeffery Parkways
New Jamesside, MT 29394', 1005);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1002.5, 'brother', 'election', '26542 Susan Junction Apt. 161
Melanieview, AS 06196', 1016.0);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1003.5, 'ago', 'dog', '1849 Ray Squares
North Donnaport, CO 31013', 1027.0);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1004.5, 'site', 'chair', '7525 Clark Grove Apt. 928
East Steven, KY 84387', 1038.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM (SELECT * FROM (SELECT * FROM performance ORDER BY date, performance.performance_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('ago',)
*/

-- Prediction Query
SELECT Date FROM performance ORDER BY Attendance DESC, performance.performance_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('site',)
*/