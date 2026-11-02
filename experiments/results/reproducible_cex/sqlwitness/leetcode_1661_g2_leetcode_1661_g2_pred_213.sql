-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (4, 3, 'start', NULL), (4, 3, 'end', 1), (0, 2, 'end', 2), (4, 1, 'end', NULL), (4, 1, 'start', 0), (2, 0, 'start', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(4, None)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(TOTAL_TIME), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, LEAD(TIMESTAMP) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY ACTIVITY_TYPE) - TIMESTAMP AS TOTAL_TIME FROM ACTIVITY) AS A WHERE NOT TOTAL_TIME IS NULL GROUP BY 1;

/*
Prediction Result:
*/