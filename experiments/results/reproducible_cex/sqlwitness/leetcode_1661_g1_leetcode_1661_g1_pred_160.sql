-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 4, 'start', 4), (0, 0, 'end', 2), (1, 3, 'end', 0), (0, 4, 'end', NULL), (4, 4, 'start', 1), (2, 0, 'start', NULL), (0, 0, 'start', 1), (3, 2, 'end', 2), (3, 4, 'start', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, 0.5)
*/

-- Prediction Query
WITH START_TIME AS (SELECT * FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start'), END_TIME AS (SELECT * FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') SELECT E.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM START_TIME AS S JOIN END_TIME AS E ON (S.MACHINE_ID, S.PROCESS_ID) = (E.MACHINE_ID, E.PROCESS_ID) GROUP BY 1;

/*
Prediction Result:
(0, 1.0)
*/