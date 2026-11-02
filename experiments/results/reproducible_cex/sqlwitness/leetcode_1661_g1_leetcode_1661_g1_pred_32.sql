-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', NULL), (3, 4, 'start', 0), (1, 1, 'end', 0), (3, 0, 'end', 2), (1, 0, 'start', 0), (2, 0, 'start', NULL), (3, 2, 'end', 4), (3, 4, 'end', NULL), (1, 2, 'start', 4), (3, 3, 'start', 1), (0, 0, 'end', 2), (1, 0, 'end', NULL), (2, 2, 'end', 0), (2, 1, 'start', 2), (1, 2, 'end', 1), (0, 3, 'start', 3), (3, 3, 'end', NULL), (4, 1, 'end', 2), (1, 3, 'start', 4), (2, 4, 'end', 4), (2, 3, 'start', 1), (3, 0, 'start', 3), (2, 1, 'end', 1), (4, 0, 'start', 3), (4, 4, 'start', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(1, -1.5)
(2, -1.0)
(3, -0.25)
*/

-- Prediction Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM (SELECT * FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS S INNER JOIN (SELECT * FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID GROUP BY S.MACHINE_ID;

/*
Prediction Result:
(1, -3.0)
(2, -1.0)
(3, -1.0)
*/