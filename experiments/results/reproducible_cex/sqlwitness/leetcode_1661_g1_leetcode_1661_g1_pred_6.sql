-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 1), (2, 3, 'end', 0), (0, 0, 'start', 4), (3, 4, 'start', 0), (1, 1, 'end', 2), (3, 0, 'end', NULL), (1, 0, 'start', 1), (4, 2, 'end', 4), (1, 2, 'start', 1), (1, 4, 'start', 4), (0, 2, 'end', 4), (1, 0, 'end', 3), (4, 3, 'start', NULL), (2, 0, 'end', NULL), (2, 2, 'end', 0), (2, 1, 'start', 3), (1, 2, 'end', 2), (1, 4, 'end', NULL), (1, 3, 'start', 0), (2, 3, 'start', 4), (1, 1, 'start', 2), (3, 0, 'start', 2), (2, 1, 'end', 2), (0, 1, 'end', 2), (1, 3, 'end', 1), (4, 4, 'start', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(1, 0.8)
(2, -2.5)
(3, None)
*/

-- Prediction Query
SELECT A.MACHINE_ID, ROUND(AVG(B.TIMESTAMP - A.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS A LEFT JOIN ACTIVITY AS B ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID WHERE A.ACTIVITY_TYPE = 'start' AND B.ACTIVITY_TYPE = 'end' GROUP BY 1;

/*
Prediction Result:
(1, 1.0)
(2, -2.5)
(3, None)
*/