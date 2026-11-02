-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 3), (2, 3, 'end', 1), (3, 4, 'start', 4), (0, 2, 'start', 2), (3, 0, 'end', 2), (0, 4, 'start', 2), (4, 2, 'end', 4), (4, 4, 'end', 1), (2, 2, 'start', 3), (3, 2, 'end', NULL), (3, 4, 'end', NULL), (3, 3, 'start', 1), (1, 0, 'end', 0), (4, 3, 'start', NULL), (3, 1, 'end', 0), (1, 4, 'end', 1), (3, 3, 'end', 3), (1, 3, 'start', 0), (4, 3, 'end', NULL), (3, 0, 'start', 1), (2, 1, 'end', 3), (0, 1, 'end', 4), (4, 2, 'start', 0), (1, 3, 'end', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(1, 3.0)
(3, 0.75)
(4, 2.0)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(TP), 3) AS PROCESSING_TIME FROM (SELECT A.MACHINE_ID, A.TIMESTAMP - B.TIMESTAMP AS TP FROM ACTIVITY AS A CROSS JOIN ACTIVITY AS B WHERE A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID AND A.ACTIVITY_TYPE = 'end' AND B.ACTIVITY_TYPE = 'start') AS T GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, 3.0)
(3, 1.5)
(4, 4.0)
*/