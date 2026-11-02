-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'end', NULL), (3, 4, 'start', 1), (1, 1, 'end', NULL), (0, 4, 'start', 0), (1, 0, 'start', 3), (2, 2, 'start', 3), (3, 2, 'end', 1), (1, 2, 'start', NULL), (0, 0, 'end', 3), (3, 1, 'start', NULL), (1, 4, 'start', 1), (1, 0, 'end', 1), (0, 4, 'end', 1), (4, 3, 'start', 2), (2, 2, 'end', 3), (1, 2, 'end', 2), (1, 4, 'end', 2), (1, 3, 'start', 1), (4, 3, 'end', 1), (2, 4, 'end', 4), (1, 1, 'start', 0), (4, 0, 'start', 3), (4, 2, 'start', 4), (4, 4, 'start', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, 1.0)
(1, -0.25)
(2, 0.0)
(4, -1.0)
*/

-- Prediction Query
SELECT E.MACHINE_ID, ROUND((AVG(E.TIMESTAMP - S.TIMESTAMP)), 3) AS PROCESSING_TIME FROM ACTIVITY AS E JOIN ACTIVITY AS S USING (MACHINE_ID, PROCESS_ID) WHERE E.ACTIVITY_TYPE = 'end' AND S.ACTIVITY_TYPE = 'start' GROUP BY 1;

/*
Prediction Result:
(0, 1.0)
(1, -0.5)
(2, 0.0)
(4, -1.0)
*/