-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 3), (3, 0, 'end', 3), (0, 4, 'start', 2), (4, 2, 'end', 3), (2, 2, 'start', 1), (3, 2, 'end', 1), (3, 4, 'end', 4), (1, 2, 'start', 4), (3, 3, 'start', NULL), (0, 2, 'end', 1), (0, 4, 'end', 4), (0, 1, 'start', NULL), (0, 3, 'start', NULL), (1, 4, 'end', NULL), (3, 3, 'end', 3), (4, 3, 'end', NULL), (1, 3, 'start', 1), (2, 4, 'end', 0), (1, 1, 'start', 1), (3, 0, 'start', 4), (4, 0, 'start', 2), (0, 3, 'end', 0), (4, 2, 'start', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, 1.0)
(1, 2.0)
(3, -0.5)
(4, 0.0)
*/

-- Prediction Query
WITH MP AS (SELECT A.MACHINE_ID, A.PROCESS_ID, A.TIMESTAMP AS T1, B.TIMESTAMP AS T2, ROUND(B.TIMESTAMP - A.TIMESTAMP, 3) AS T_GAP FROM ACTIVITY AS A JOIN ACTIVITY AS B ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID AND A.ACTIVITY_TYPE <> B.ACTIVITY_TYPE WHERE A.ACTIVITY_TYPE = 'start') SELECT MACHINE_ID, ROUND(AVG(T_GAP), 3) AS PROCESSING_TIME FROM MP GROUP BY MACHINE_ID;

/*
Prediction Result:
(0, 2.0)
(1, 2.0)
(3, -1.0)
(4, 0.0)
*/