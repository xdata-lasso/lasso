-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, -1, 'start', 1), (4, -1, 'end', 1), (3, 2, 'end', NULL), (2, -1, 'start', 0), (1, 0, 'end', 4), (0, 1, 'start', 2), (3, 1, 'end', 2), (4, -1, 'start', NULL), (3, 3, 'end', 2), (-1, 0, 'start', NULL), (-1, 2, 'end', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(4, None)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(DUR), 3) AS PROCESSING_TIME FROM (SELECT A1.MACHINE_ID, A1.PROCESS_ID, A2.TIMESTAMP - A1.TIMESTAMP AS DUR FROM ACTIVITY AS A1 CROSS JOIN ACTIVITY AS A2 WHERE A1.ACTIVITY_TYPE <> A2.ACTIVITY_TYPE AND A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID) AS A3 WHERE A3.DUR > 0 GROUP BY 1;

/*
Prediction Result:
*/