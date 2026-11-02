-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 1, 'end', NULL), (3, 0, 'end', 4), (1, 1, 'start', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT MACHINE_ID, ROUND(CAST(SUM(IIF(ACTIVITY_TYPE = 'start', -TIMESTAMP, TIMESTAMP)) AS REAL) / COUNT(DISTINCT PROCESS_ID), 3) AS PROCESSING_TIME FROM ACTIVITY GROUP BY MACHINE_ID;

/*
Prediction Result:
(0, None)
(1, -3.0)
(3, 4.0)
*/