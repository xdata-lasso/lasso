-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 10.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 20.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 10.0)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(COALESCE(CAST((SUM(CASE WHEN ACTIVITY_TYPE = 'end' THEN TIMESTAMP ELSE 0 END) - SUM(CASE WHEN ACTIVITY_TYPE = 'start' THEN TIMESTAMP ELSE 0 END)) AS REAL) / COUNT(DISTINCT PROCESS_ID), 0), 3) AS PROCESSING_TIME FROM ACTIVITY GROUP BY 1 ORDER BY 1, MACHINE_ID NULLS LAST, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(1, 2.5)
*/