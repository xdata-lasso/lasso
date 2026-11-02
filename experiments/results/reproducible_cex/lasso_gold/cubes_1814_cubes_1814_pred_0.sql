-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1025.5, 'difference', 'money', 'TD Garden', 1027);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1026.5, 'reality', 'individual', 'Bell Centre', 1038.0);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1029.5, 'usually', 'question', 'TD Garden', 1031);
INSERT INTO "performance" ("performance_id", "date", "host", "location", "attendance") VALUES (1030.5, 'who', 'low', 'Bell Centre', 1042.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "attendance" FROM "performance" WHERE ("location" = 'TD Garden' OR "location" = 'Bell Centre') ORDER BY attendance, performance.performance_id NULLS LAST;

/*
Gold Result:
(1027,)
(1031,)
(1038,)
(1042,)
*/

-- Prediction Query
SELECT Attendance FROM performance WHERE LOCATION = 'TD Garden' OR LOCATION = 'Bell Centre';

/*
Prediction Result:
(1027,)
(1038,)
(1031,)
(1042,)
*/