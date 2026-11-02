-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'end', NULL), (3, 4, 'start', NULL), (1, 1, 'end', 0), (2, 4, 'end', 1), (1, 1, 'start', 2), (1, 2, 'end', 0), (3, 0, 'start', NULL), (2, 1, 'start', 2), (0, 0, 'end', 2), (1, 2, 'start', 2), (0, 4, 'start', 0), (4, 0, 'end', 2), (1, 0, 'end', 1), (1, 0, 'start', 2), (4, 1, 'end', 4), (4, 2, 'end', 0), (4, 4, 'end', 0), (2, 2, 'start', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, -1.667)
(2, None)
*/

-- Prediction Query
WITH TIME_DIFF AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP - LAG(TIMESTAMP, 1) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY TIMESTAMP) AS PROCESSING_TIME FROM ACTIVITY) SELECT MACHINE_ID, ROUND(AVG(PROCESSING_TIME), 3) AS PROCESSING_TIME FROM TIME_DIFF WHERE NOT PROCESSING_TIME IS NULL GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, 1.667)
*/