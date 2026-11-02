-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 0), (2, 3, 'end', 2), (3, 4, 'start', 3), (3, 0, 'end', 3), (0, 4, 'start', 1), (4, 2, 'end', NULL), (2, 0, 'start', 3), (2, 2, 'start', 0), (3, 2, 'end', 1), (3, 4, 'end', 2), (3, 3, 'start', 4), (0, 0, 'end', 2), (1, 4, 'start', 4), (3, 1, 'start', 2), (0, 2, 'end', 1), (0, 4, 'end', 3), (4, 3, 'start', 3), (2, 0, 'end', 4), (0, 1, 'start', 1), (2, 1, 'start', NULL), (3, 1, 'end', NULL), (3, 3, 'end', NULL), (1, 3, 'start', 1), (2, 3, 'start', 2), (1, 1, 'start', NULL), (3, 0, 'start', 1), (0, 1, 'end', 2), (4, 2, 'start', 0), (1, 3, 'end', 0), (4, 4, 'start', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(0, 1.5)
(1, -1.0)
(2, 0.5)
(3, 0.4)
(4, None)
*/

-- Prediction Query
SELECT T1.MACHINE_ID, ROUND(AVG(T2.TIMESTAMP - T1.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS T1 INNER JOIN ACTIVITY AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID AND T1.ACTIVITY_TYPE = 'start' AND T2.ACTIVITY_TYPE = 'end' GROUP BY T1.MACHINE_ID;

/*
Prediction Result:
(0, 1.5)
(1, -1.0)
(2, 0.5)
(3, 0.667)
(4, None)
*/