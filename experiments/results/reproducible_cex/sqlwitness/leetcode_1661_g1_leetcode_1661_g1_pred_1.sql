-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 0, 'start', 3), (1, 1, 'end', NULL), (0, 2, 'start', NULL), (3, 0, 'end', 4), (1, 0, 'start', NULL), (1, 2, 'start', 0), (3, 3, 'start', 3), (0, 0, 'end', 4), (1, 4, 'start', 4), (1, 0, 'end', 4), (4, 1, 'start', 3), (2, 4, 'start', 3), (2, 2, 'end', 3), (1, 2, 'end', 4), (3, 1, 'end', 4), (1, 4, 'end', NULL), (4, 1, 'end', 3), (4, 3, 'end', 0), (1, 3, 'start', 0), (2, 3, 'start', 2), (1, 1, 'start', 0), (3, 0, 'start', 4), (4, 0, 'start', 1), (4, 2, 'start', 4), (1, 3, 'end', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, 1.0)
(1, 0.8)
(3, 0.0)
(4, 0.0)
*/

-- Prediction Query
SELECT A1.MACHINE_ID, ROUND(AVG(A2.TIMESTAMP - A1.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY 1;

/*
Prediction Result:
(0, 1.0)
(1, 4.0)
(3, 0.0)
(4, 0.0)
*/