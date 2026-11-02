-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO performance (performance_id, date, host, location, attendance) VALUES (0.0, 'default2', 'default1', 'TD Garden', NULL), (1.0, 'TD Garden', 'default1', 'TD Garden', 1), (16666.666667, 'Bell Centre', 'Bell Centre', NULL, NULL), (33333.333333, 'TD Garden', 'TD Garden', NULL, 1), (50000.0, NULL, 'Bell Centre', 'Bell Centre', NULL), (66666.666667, 'default2', NULL, 'default2', NULL), (83333.333333, 'Bell Centre', 'Bell Centre', NULL, NULL), (100000.0, 'default2', 'TD Garden', 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "attendance" FROM "performance" WHERE ("location" = 'TD Garden' OR "location" = 'Bell Centre') ORDER BY attendance, performance.performance_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(1,)
*/

-- Prediction Query
SELECT Attendance FROM performance WHERE LOCATION = 'TD Garden' OR LOCATION = 'Bell Centre';

/*
Prediction Result:
(None,)
(1,)
(None,)
*/