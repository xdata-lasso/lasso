-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'start', 2), (3, 2, 'end', 0), (3, 2, 'start', NULL), (3, 4, 'end', 3), (1, 2, 'start', 4), (3, 0, 'start', 0), (2, 1, 'start', 3), (3, 0, 'end', 2), (0, 3, 'start', 0), (3, 3, 'start', 4), (3, 3, 'end', 1), (4, 1, 'start', 4), (2, 4, 'start', 0), (0, 3, 'end', NULL), (4, 1, 'end', 4), (2, 0, 'end', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, None)
(3, -0.333)
(4, 0.0)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(DIFF), 3) AS PROCESSING_TIME FROM (SELECT A.MACHINE_ID, (A.TIMESTAMP - B.TIMESTAMP) AS DIFF FROM ACTIVITY AS A CROSS JOIN ACTIVITY AS B WHERE A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID AND A.ACTIVITY_TYPE = 'end' AND B.ACTIVITY_TYPE = 'start') AS TMP GROUP BY MACHINE_ID ORDER BY MACHINE_ID, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(0, None)
(3, -0.5)
(4, 0.0)
*/