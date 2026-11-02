-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (60, 9, 'end', -146);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (62, 8, 'end', -507);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(RUNTIME), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, ROUND(MAX(TIMESTAMP) - MIN(TIMESTAMP), 3) AS RUNTIME FROM ACTIVITY GROUP BY 1, 2) AS TBL GROUP BY 1;

/*
Prediction Result:
(60, 0.0)
(62, 0.0)
*/