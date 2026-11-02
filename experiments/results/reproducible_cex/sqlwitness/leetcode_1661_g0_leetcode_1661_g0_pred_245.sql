-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 1), (2, 3, 'start', 4), (2, 2, 'start', NULL), (4, 4, 'start', 2), (1, 2, 'end', 4), (1, 1, 'start', 3), (0, 4, 'start', 1), (1, 2, 'start', 0), (3, 1, 'end', 1), (0, 1, 'start', 1), (0, 3, 'start', 3), (4, 2, 'end', NULL), (4, 0, 'end', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1, 4.0)
*/

-- Prediction Query
WITH T1 AS (SELECT MACHINE_ID, PROCESS_ID, LAG(TIMESTAMP) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY ACTIVITY_TYPE) AS START_TIME, TIMESTAMP AS END_TIME FROM ACTIVITY), T2 AS (SELECT MACHINE_ID, PROCESS_ID, (END_TIME - START_TIME) AS PROCESSING_TIME FROM T1 WHERE NOT END_TIME IS NULL AND NOT START_TIME IS NULL GROUP BY MACHINE_ID, PROCESS_ID) SELECT MACHINE_ID, ROUND(AVG(PROCESSING_TIME), 3) AS PROCESSING_TIME FROM T2 GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, -4.0)
*/