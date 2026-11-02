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
WITH TIME_DIFF AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP - LAG(TIMESTAMP, 1) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY TIMESTAMP) AS PROCESSING_TIME FROM ACTIVITY) SELECT MACHINE_ID, ROUND(AVG(PROCESSING_TIME), 3) AS PROCESSING_TIME FROM TIME_DIFF WHERE NOT PROCESSING_TIME IS NULL GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, 15.0)
(2, 4.833)
*/