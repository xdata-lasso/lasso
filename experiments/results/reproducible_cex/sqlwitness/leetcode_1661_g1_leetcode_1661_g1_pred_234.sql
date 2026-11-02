-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 0), (3, 2, 'end', NULL), (2, 3, 'end', 1), (3, 0, 'start', 3), (2, 1, 'start', 3), (3, 3, 'start', 0), (4, 0, 'end', 1), (3, 3, 'end', 1), (0, 3, 'end', 1), (4, 2, 'end', NULL), (4, 3, 'start', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(3, 0.5)
*/

-- Prediction Query
SELECT ASS.MACHINE_ID, ROUND(AVG(AE.TIMESTAMP - ASS.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS ASS INNER JOIN ACTIVITY AS AE ON ASS.MACHINE_ID = AE.MACHINE_ID AND ASS.PROCESS_ID = AE.PROCESS_ID AND ASS.ACTIVITY_TYPE = 'start' AND AE.ACTIVITY_TYPE = 'end' GROUP BY ASS.MACHINE_ID;

/*
Prediction Result:
(3, 1.0)
*/