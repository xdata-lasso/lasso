-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 10.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 11.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 20.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'end', 21.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 3, 'start', 30.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 3, 'end', 33.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 100.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'end', 105.1236);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'start', 200.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'end', 205.1234);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 1.667)
(2, 5.123)
*/

-- Prediction Query
WITH TOTALS AS (SELECT MACHINE_ID, SUM(CASE WHEN ACTIVITY_TYPE = 'start' THEN TIMESTAMP END) AS STARTS, SUM(CASE WHEN ACTIVITY_TYPE = 'end' THEN TIMESTAMP END) AS ENDS, COUNT(DISTINCT PROCESS_ID) AS TOTAL_PROCESSES FROM ACTIVITY GROUP BY 1) SELECT MACHINE_ID, ROUND(CAST((ENDS - STARTS) AS REAL) / TOTAL_PROCESSES, 3) AS PROCESSING_TIME FROM TOTALS GROUP BY 1;

/*
Prediction Result:
(1, 1.667)
(2, 5.124)
*/