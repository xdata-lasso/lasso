-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 4), (0, 0, 'start', 1), (3, 4, 'start', 2), (1, 0, 'start', NULL), (2, 0, 'start', 0), (3, 2, 'end', NULL), (3, 4, 'end', NULL), (1, 2, 'start', 4), (3, 3, 'start', 3), (3, 1, 'start', 3), (0, 2, 'end', NULL), (4, 1, 'start', 0), (4, 3, 'start', 2), (2, 1, 'start', 3), (3, 1, 'end', 3), (1, 4, 'end', 3), (3, 3, 'end', NULL), (4, 1, 'end', NULL), (4, 3, 'end', 4), (1, 1, 'start', 3), (0, 1, 'end', 3), (4, 0, 'start', 1), (4, 2, 'start', 3), (4, 4, 'start', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(3, 0.0)
(4, 2.0)
*/

-- Prediction Query
WITH E AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS END_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end'), S AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS START_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') SELECT E.MACHINE_ID, ROUND(CAST(SUM(END_TIME - START_TIME) AS REAL) / COUNT(E.PROCESS_ID), 3) AS PROCESSING_TIME FROM E JOIN S ON E.MACHINE_ID = S.MACHINE_ID AND E.PROCESS_ID = S.PROCESS_ID GROUP BY E.MACHINE_ID;

/*
Prediction Result:
(3, 0.0)
(4, 1.0)
*/