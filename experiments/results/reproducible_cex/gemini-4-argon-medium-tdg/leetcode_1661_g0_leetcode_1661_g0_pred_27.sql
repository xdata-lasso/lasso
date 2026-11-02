-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 10.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 20.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 50.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 3, 'end', 100.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 5.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 1, 'end', 15.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (4, 1, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (4, 1, 'end', 2.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (4, 1, 'pause', 1.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1, 10.0)
(4, 1.0)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(CAST(SUM(CASE WHEN ACTIVITY_TYPE = 'start' THEN -TIMESTAMP WHEN ACTIVITY_TYPE = 'end' THEN TIMESTAMP ELSE 0 END) AS REAL) / COUNT(DISTINCT PROCESS_ID), 3) AS PROCESSING_TIME FROM ACTIVITY GROUP BY 1;

/*
Prediction Result:
(1, 20.0)
(2, -5.0)
(3, 15.0)
(4, 1.0)
*/