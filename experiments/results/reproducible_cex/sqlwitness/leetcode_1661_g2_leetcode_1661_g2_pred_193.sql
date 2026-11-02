-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 4), (2, 0, 'end', 1), (3, 0, 'start', 0), (3, 1, 'end', 4), (1, 0, 'end', 2), (4, 2, 'end', NULL), (0, 4, 'end', 4), (2, 0, 'start', 0), (1, 3, 'start', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(2, 1.0)
*/

-- Prediction Query
WITH NEW AS (SELECT MACHINE_ID, PROCESS_ID, LAG(TIMESTAMP, 1) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY ACTIVITY_TYPE) AS START, TIMESTAMP FROM ACTIVITY) SELECT MACHINE_ID, ROUND(AVG(TIMESTAMP - START), 3) AS PROCESSING_TIME FROM NEW WHERE NOT START IS NULL GROUP BY MACHINE_ID;

/*
Prediction Result:
(2, -1.0)
*/