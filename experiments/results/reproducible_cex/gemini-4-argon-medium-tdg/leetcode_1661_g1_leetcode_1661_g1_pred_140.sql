-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (5, 1, 'START', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (5, 1, 'END', 5.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (5, 1, 'start', 2.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (5, 1, 'end', 4.5);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (6, 1, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (6, 1, 'end', NULL);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (6, 2, 'start', 2.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (6, 2, 'end', 6.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(5, 2.5)
(6, 2.0)
*/

-- Prediction Query
SELECT ACTIVITY_END.MACHINE_ID AS MACHINE_ID, ROUND(AVG(ACTIVITY_END.TIMESTAMP - ACTIVITY_START.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS ACTIVITY_END JOIN ACTIVITY AS ACTIVITY_START ON (ACTIVITY_END.MACHINE_ID = ACTIVITY_START.MACHINE_ID AND ACTIVITY_END.PROCESS_ID = ACTIVITY_START.PROCESS_ID AND ACTIVITY_END.ACTIVITY_TYPE = 'end' AND ACTIVITY_START.ACTIVITY_TYPE = 'start') GROUP BY ACTIVITY_END.MACHINE_ID;

/*
Prediction Result:
(5, 2.5)
(6, 4.0)
*/