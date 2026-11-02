-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (4, 0, 'end', 4), (0, 4, 'start', 4), (2, 2, 'start', 2), (2, 3, 'start', NULL), (0, 0, 'end', 3), (2, 1, 'start', 2), (2, 1, 'end', 2), (1, 1, 'end', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(2, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT MACHINE_ID, TIMESTAMP AS START FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start'), CTE2 AS (SELECT MACHINE_ID, TIMESTAMP AS END FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') SELECT CTE.MACHINE_ID, ROUND(AVG(END - START), 3) AS PROCESSING_TIME FROM CTE JOIN CTE2 ON CTE.MACHINE_ID = CTE2.MACHINE_ID GROUP BY 1;

/*
Prediction Result:
(0, -1.0)
(2, 0.0)
*/