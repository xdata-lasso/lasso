-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 10.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', NULL);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 10.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'stop', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(TIMESTAMP), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, SUM(IIF(ACTIVITY_TYPE = 'end', TIMESTAMP, 0)) - SUM(IIF(ACTIVITY_TYPE = 'start', TIMESTAMP, 0)) AS TIMESTAMP FROM ACTIVITY GROUP BY MACHINE_ID, PROCESS_ID HAVING COUNT(PROCESS_ID) = 2) AS ACTIVITY_TIME GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, -10.0)
(2, -10.0)
*/