-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', NULL), (3, 4, 'start', 3), (0, 2, 'start', 1), (3, 0, 'end', 0), (1, 0, 'start', 3), (4, 0, 'end', 3), (2, 0, 'start', 3), (3, 2, 'end', 3), (3, 4, 'end', 1), (3, 3, 'start', NULL), (1, 0, 'end', 1), (4, 1, 'start', NULL), (4, 3, 'start', 4), (2, 0, 'end', 2), (2, 2, 'end', 3), (0, 1, 'start', 2), (1, 2, 'end', 1), (0, 3, 'start', 3), (3, 1, 'end', 0), (1, 4, 'end', 4), (3, 3, 'end', 0), (4, 1, 'end', 4), (1, 3, 'start', NULL), (0, 1, 'end', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, 2.0)
(1, -2.0)
(2, -1.0)
(3, -0.667)
(4, None)
*/

-- Prediction Query
WITH START_TIME AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start' GROUP BY MACHINE_ID, PROCESS_ID ORDER BY MACHINE_ID, PROCESS_ID NULLS LAST, TIMESTAMP NULLS LAST), END_TIME AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end' GROUP BY MACHINE_ID, PROCESS_ID ORDER BY MACHINE_ID, PROCESS_ID NULLS LAST, TIMESTAMP NULLS LAST), DURATION AS (SELECT S.MACHINE_ID, ROUND(E.TIMESTAMP - S.TIMESTAMP, 3) AS DURATIONS FROM START_TIME AS S JOIN END_TIME AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID) SELECT MACHINE_ID, ROUND(AVG(DURATIONS), 3) AS PROCESSING_TIME FROM DURATION GROUP BY MACHINE_ID ORDER BY MACHINE_ID, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(0, 2.0)
(1, -2.0)
(2, -1.0)
(3, -2.0)
(4, None)
*/