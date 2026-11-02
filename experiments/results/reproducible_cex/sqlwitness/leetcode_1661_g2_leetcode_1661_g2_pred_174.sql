-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (-1, -1, 'end', 1), (4, 1, 'end', -1), (3, 4, 'start', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(END_T - START_T), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, MAX(CASE WHEN ACTIVITY_TYPE = 'start' THEN TIMESTAMP ELSE 0 END) AS START_T, MAX(CASE WHEN ACTIVITY_TYPE = 'end' THEN TIMESTAMP ELSE 0 END) AS END_T FROM ACTIVITY GROUP BY MACHINE_ID, PROCESS_ID) AS A GROUP BY MACHINE_ID;

/*
Prediction Result:
(-1, 1.0)
(3, None)
(4, -1.0)
*/