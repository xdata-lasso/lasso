-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 0.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'end', 0.0004);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'start', 0.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'end', 0.0004);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'start', 0.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'end', 0.001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(2, 0.001)
*/

-- Prediction Query
WITH A AS (SELECT MACHINE_ID, PROCESS_ID, ROUND(MAX(TIMESTAMP) - MIN(TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY GROUP BY MACHINE_ID, PROCESS_ID) SELECT MACHINE_ID, ROUND(CAST(SUM(PROCESSING_TIME) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM A GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, 0.0)
(2, 0.0)
*/