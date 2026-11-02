-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 10.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 25.5);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 50.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 3, 'end', 100.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 5.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 1, 'end', 12.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1, 15.5)
*/

-- Prediction Query
WITH A AS (SELECT MACHINE_ID, MAX(TIMESTAMP) - MIN(TIMESTAMP) AS PROCESSING_TIME FROM ACTIVITY GROUP BY MACHINE_ID, PROCESS_ID) SELECT MACHINE_ID, ROUND(AVG(PROCESSING_TIME), 3) AS PROCESSING_TIME FROM A GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, 5.167)
(2, 0.0)
(3, 0.0)
*/