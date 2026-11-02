-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (58, 58, 'end', NULL);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (60, 58, 'end', -507);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH PROCESS_TIMES AS (SELECT MACHINE_ID, MAX(TIMESTAMP) - MIN(TIMESTAMP) AS TIME_TAKEN FROM ACTIVITY GROUP BY MACHINE_ID, PROCESS_ID) SELECT MACHINE_ID, ROUND(AVG(TIME_TAKEN), 3) AS PROCESSING_TIME FROM PROCESS_TIMES GROUP BY MACHINE_ID;

/*
Prediction Result:
(58, None)
(60, 0.0)
*/