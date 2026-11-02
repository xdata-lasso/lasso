-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', NULL), (3, 4, 'start', 1), (1, 1, 'end', NULL), (3, 0, 'end', 3), (0, 4, 'start', 2), (1, 0, 'start', 0), (2, 0, 'start', 1), (3, 2, 'end', 2), (3, 4, 'end', NULL), (3, 3, 'start', 2), (4, 1, 'start', 3), (2, 4, 'start', 0), (0, 4, 'end', 4), (2, 0, 'end', 4), (2, 2, 'end', 1), (1, 2, 'end', 1), (3, 1, 'end', NULL), (3, 3, 'end', 0), (1, 3, 'start', NULL), (2, 3, 'start', 4), (0, 1, 'end', 1), (4, 2, 'start', 4), (1, 3, 'end', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, 2.0)
(1, None)
(2, 3.0)
(3, -0.667)
*/

-- Prediction Query
SELECT T.MACHINE_ID, ROUND(AVG(DIFF), 3) AS PROCESSING_TIME FROM (SELECT A1.MACHINE_ID, (A2.TIMESTAMP - A1.TIMESTAMP) AS DIFF FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID WHERE A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end') AS T GROUP BY T.MACHINE_ID;

/*
Prediction Result:
(0, 2.0)
(1, None)
(2, 3.0)
(3, -2.0)
*/