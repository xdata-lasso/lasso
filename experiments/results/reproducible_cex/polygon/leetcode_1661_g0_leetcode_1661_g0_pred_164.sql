-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (9, 11, 'end', 841);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (8, 10, 'end', -743);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT A.MACHINE_ID, A.PROCESS_ID, A.ACTIVITY_TYPE, CASE WHEN A.ACTIVITY_TYPE = 'start' THEN -A.TIMESTAMP ELSE A.TIMESTAMP END AS PROCESSINGTIME FROM ACTIVITY AS A) SELECT MACHINE_ID, ROUND(CAST(SUM(PROCESSINGTIME) AS REAL) / COUNT(DISTINCT (PROCESS_ID)), 3) AS PROCESSING_TIME FROM CTE GROUP BY MACHINE_ID;

/*
Prediction Result:
(8, -743.0)
(9, 841.0)
*/