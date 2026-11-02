-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 4, 'start', NULL), (1, 1, 'end', 1), (1, 0, 'start', NULL), (4, 4, 'end', NULL), (1, 2, 'start', NULL), (1, 0, 'end', 0), (0, 4, 'end', NULL), (2, 0, 'end', 2), (1, 2, 'end', 1), (2, 1, 'start', 4), (1, 4, 'end', 1), (3, 3, 'end', 3), (4, 1, 'end', NULL), (1, 3, 'start', 4), (2, 4, 'end', 1), (1, 1, 'start', 1), (4, 0, 'start', 0), (0, 3, 'end', NULL), (4, 2, 'start', 0), (1, 3, 'end', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1, -0.5)
*/

-- Prediction Query
WITH S AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS START_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start'), E AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS END_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') SELECT E.MACHINE_ID AS MACHINE_ID, ROUND(CAST(SUM(E.END_TIME - S.START_TIME) AS REAL) / COUNT(1), 3) AS PROCESSING_TIME FROM S AS S INNER JOIN E AS E ON E.MACHINE_ID = S.MACHINE_ID AND E.PROCESS_ID = S.PROCESS_ID GROUP BY E.MACHINE_ID;

/*
Prediction Result:
(1, -0.25)
*/