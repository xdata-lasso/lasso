-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 4), (3, 4, 'start', 0), (1, 1, 'end', NULL), (3, 0, 'end', 3), (2, 2, 'start', 4), (3, 2, 'end', 1), (3, 4, 'end', NULL), (3, 3, 'start', 2), (1, 4, 'start', NULL), (0, 2, 'end', 4), (4, 1, 'start', NULL), (2, 1, 'start', 0), (0, 3, 'start', 4), (3, 1, 'end', 2), (3, 3, 'end', 3), (1, 3, 'start', 0), (3, 0, 'start', NULL), (0, 1, 'end', NULL), (4, 2, 'start', 4), (1, 3, 'end', 0), (4, 4, 'start', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(1, 0.0)
(3, -0.5)
*/

-- Prediction Query
WITH X AS (SELECT MACHINE_ID, ROUND(CAST(SUM(TOTAL) AS REAL) / COUNT(MACHINE_ID), 3) AS PROCESSING_TIME FROM (SELECT S.MACHINE_ID, S.PROCESS_ID, ABS(S.TIMESTAMP - E.TIMESTAMP) AS TOTAL FROM ACTIVITY AS S INNER JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND E.PROCESS_ID = S.PROCESS_ID WHERE S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end') AS P GROUP BY MACHINE_ID) SELECT * FROM X;

/*
Prediction Result:
(1, 0.0)
(3, 1.0)
*/