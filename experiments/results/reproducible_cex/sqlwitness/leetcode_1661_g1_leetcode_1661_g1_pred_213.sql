-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 1), (2, 3, 'start', 4), (1, 1, 'start', 3), (1, 1, 'end', 0), (0, 1, 'start', 0), (0, 2, 'start', 0), (2, 1, 'end', 3), (3, 3, 'start', 1), (0, 3, 'start', 0), (3, 1, 'end', 2), (2, 1, 'start', 4), (4, 3, 'start', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(1, -3.0)
(2, -1.0)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(TOTAL_TIME), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, LEAD(TIMESTAMP) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY ACTIVITY_TYPE) - TIMESTAMP AS TOTAL_TIME FROM ACTIVITY) AS A WHERE NOT TOTAL_TIME IS NULL GROUP BY 1;

/*
Prediction Result:
(1, 3.0)
(2, 1.0)
*/