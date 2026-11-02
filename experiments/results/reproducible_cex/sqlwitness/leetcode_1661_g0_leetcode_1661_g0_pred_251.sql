-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (-1, 2, 'end', -1), (0, 0, 'end', -1), (4, 4, 'end', -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.MACHINE_ID, ROUND(CAST((SUM(CASE WHEN A.ACTIVITY_TYPE = 'end' THEN A.TIMESTAMP ELSE 0 END) - SUM(CASE WHEN A.ACTIVITY_TYPE = 'start' THEN A.TIMESTAMP ELSE 0 END)) AS REAL) / COUNT(DISTINCT A.PROCESS_ID), 3) AS PROCESSING_TIME FROM ACTIVITY AS A GROUP BY A.MACHINE_ID ORDER BY A.MACHINE_ID, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(-1, -1.0)
(0, -1.0)
(4, -1.0)
*/