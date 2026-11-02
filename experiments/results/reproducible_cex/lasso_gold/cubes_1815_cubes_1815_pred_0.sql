-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1006.5, 'list', 'true', '4235 Christopher Court Suite 594
Lake Stephenville, MS 10829', 1010);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1007.5, 'perform', 'according', '4235 Christopher Court Suite 594
Lake Stephenville, MS 10829', 1010);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1008.5, 'fall', 'song', '4235 Christopher Court Suite 594
Lake Stephenville, MS 10829', 1010);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1009.5, 'table', 'sure', '4235 Christopher Court Suite 594
Lake Stephenville, MS 10829', 1010);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1011.5, NULL, 'present', '34131 Ramirez Roads
Franciscostad, IL 88342', 1015);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1012.5, NULL, 'value', '34131 Ramirez Roads
Franciscostad, IL 88342', 1015);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1013.5, NULL, 'training', '34131 Ramirez Roads
Franciscostad, IL 88342', 1015);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1014.5, NULL, 'high', '34131 Ramirez Roads
Franciscostad, IL 88342', 1015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT * FROM (SELECT * FROM (SELECT attendance, LOCATION, COUNT(*) AS n FROM performance GROUP BY attendance, LOCATION) ORDER BY LOCATION DESC) LIMIT 1);

/*
Gold Result:
('4235 Christopher Court Suite 594\nLake Stephenville, MS 10829',)
*/

-- Prediction Query
SELECT LOCATION FROM performance GROUP BY LOCATION ORDER BY COUNT(*) DESC, LOCATION NULLS LAST LIMIT 1;

/*
Prediction Result:
('34131 Ramirez Roads\nFranciscostad, IL 88342',)
*/