-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 1, 'start', NULL), (0, 2, 'start', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT *, CASE WHEN ACTIVITY_TYPE = 'start' THEN (-1) * TIMESTAMP ELSE TIMESTAMP END AS TIME_TRUE FROM ACTIVITY) SELECT MACHINE_ID, ROUND(CAST(2 * SUM(TIME_TRUE) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM CTE GROUP BY MACHINE_ID;

/*
Prediction Result:
(0, -8.0)
(3, None)
*/