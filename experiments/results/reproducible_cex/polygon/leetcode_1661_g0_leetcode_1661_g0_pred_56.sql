-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (58, 58, 'end', 97);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (65, 58, 'end', -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.MACHINE_ID AS MACHINE_ID, ROUND(CAST((A.END_TIMESTAMP - A.START_TIMESTAMP) AS REAL) / A.PROCESS_COUNT, 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, COUNT(DISTINCT PROCESS_ID) AS PROCESS_COUNT, SUM(CASE WHEN ACTIVITY_TYPE = 'start' THEN TIMESTAMP ELSE 0 END) AS START_TIMESTAMP, SUM(CASE WHEN ACTIVITY_TYPE = 'end' THEN TIMESTAMP ELSE 0 END) AS END_TIMESTAMP FROM ACTIVITY GROUP BY MACHINE_ID) AS A GROUP BY MACHINE_ID;

/*
Prediction Result:
(58, 97.0)
(65, -1.0)
*/