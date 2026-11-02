-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 0), (2, 3, 'end', 1), (0, 0, 'start', 1), (3, 4, 'start', 0), (3, 0, 'end', NULL), (0, 4, 'start', NULL), (4, 4, 'end', 1), (2, 2, 'start', 2), (3, 2, 'end', 3), (3, 4, 'end', 2), (1, 2, 'start', 2), (3, 3, 'start', 0), (3, 1, 'start', 1), (0, 0, 'end', 0), (1, 4, 'start', NULL), (1, 0, 'end', 0), (0, 1, 'start', 1), (0, 3, 'start', 2), (1, 4, 'end', 2), (3, 3, 'end', 0), (3, 0, 'start', 4), (0, 1, 'end', 2), (4, 0, 'start', NULL), (1, 3, 'end', 1), (4, 4, 'start', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, 0.0)
(1, None)
(3, 1.25)
(4, None)
*/

-- Prediction Query
SELECT B.MACHINE_ID, ROUND(AVG(A.TIMESTAMP - B.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS B JOIN ACTIVITY AS A ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID AND A.ACTIVITY_TYPE = 'end' AND B.ACTIVITY_TYPE = 'start' GROUP BY A.MACHINE_ID;

/*
Prediction Result:
(0, 0.0)
(1, None)
(3, 1.667)
(4, None)
*/