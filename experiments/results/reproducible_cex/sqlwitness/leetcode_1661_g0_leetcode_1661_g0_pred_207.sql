-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 2), (1, 1, 'end', NULL), (0, 1, 'start', 3), (2, 1, 'start', 2), (3, 0, 'end', 2), (2, 1, 'end', 3), (4, 2, 'end', 2), (2, 0, 'start', NULL), (4, 3, 'end', 4), (4, 4, 'start', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1, None)
(2, 1.0)
*/

-- Prediction Query
WITH TIME_DIFF AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP - LAG(TIMESTAMP, 1) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY TIMESTAMP) AS PROCESSING_TIME FROM ACTIVITY) SELECT MACHINE_ID, ROUND(AVG(PROCESSING_TIME), 3) AS PROCESSING_TIME FROM TIME_DIFF WHERE NOT PROCESSING_TIME IS NULL GROUP BY MACHINE_ID;

/*
Prediction Result:
(2, 1.0)
*/