-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'pause', 2.5);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 6.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'START', 10.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'END', 50.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'abort', 0.5);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 2.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'end', 9.25);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'zzz', 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1, 5.0)
(2, 7.25)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(TIMESTAMP), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, SUM(IIF(ACTIVITY_TYPE = 'end', TIMESTAMP, 0)) - SUM(IIF(ACTIVITY_TYPE = 'start', TIMESTAMP, 0)) AS TIMESTAMP FROM ACTIVITY GROUP BY MACHINE_ID, PROCESS_ID HAVING COUNT(PROCESS_ID) = 2) AS ACTIVITY_TIME GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, 0.0)
*/