-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (11, 9, 'end', -178);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (10, 8, 'end', -721);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT A.MACHINE_ID, A.PROCESS_ID, A.ACTIVITY_TYPE, CASE WHEN A.ACTIVITY_TYPE = 'start' THEN -A.TIMESTAMP ELSE A.TIMESTAMP END AS PROCESSINGTIME FROM ACTIVITY AS A) SELECT MACHINE_ID, ROUND(CAST(SUM(PROCESSINGTIME) AS REAL) / COUNT(DISTINCT (PROCESS_ID)), 3) AS PROCESSING_TIME FROM CTE GROUP BY MACHINE_ID;

/*
Prediction Result:
(10, -721.0)
(11, -178.0)
*/