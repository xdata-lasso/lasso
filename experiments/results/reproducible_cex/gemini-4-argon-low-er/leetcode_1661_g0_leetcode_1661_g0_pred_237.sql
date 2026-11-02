-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'start', 10.0);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'other', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(TIMESTAMP), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, SUM(IIF(ACTIVITY_TYPE = 'end', TIMESTAMP, 0)) - SUM(IIF(ACTIVITY_TYPE = 'start', TIMESTAMP, 0)) AS TIMESTAMP FROM ACTIVITY GROUP BY MACHINE_ID, PROCESS_ID HAVING COUNT(PROCESS_ID) = 2) AS ACTIVITY_TIME GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, -10.0)
*/