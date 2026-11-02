-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 5.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 2.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'end', NULL);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', NULL);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'end', 3.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'end', 4.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 2.0)
(2, 1.5)
*/

-- Prediction Query
SELECT ACTIVITY_END.MACHINE_ID AS MACHINE_ID, ROUND(AVG(ACTIVITY_END.TIMESTAMP - ACTIVITY_START.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS ACTIVITY_END JOIN ACTIVITY AS ACTIVITY_START ON (ACTIVITY_END.MACHINE_ID = ACTIVITY_START.MACHINE_ID AND ACTIVITY_END.PROCESS_ID = ACTIVITY_START.PROCESS_ID AND ACTIVITY_END.ACTIVITY_TYPE = 'end' AND ACTIVITY_START.ACTIVITY_TYPE = 'start') GROUP BY ACTIVITY_END.MACHINE_ID;

/*
Prediction Result:
(1, 4.0)
(2, 3.0)
*/