-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (10, 5, 'start', 100.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (10, 5, 'end', 150.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (10, 5, 'START', 10.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (10, 5, 'END', 500.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (20, 5, 'start', 200.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (20, 5, 'end', NULL);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (20, 6, 'start', 10.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (20, 6, 'end', 20.000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(10, 50.0)
(20, 5.0)
*/

-- Prediction Query
SELECT A.MACHINE_ID, ROUND(AVG(B.TIMESTAMP - A.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS A LEFT JOIN ACTIVITY AS B ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID WHERE A.ACTIVITY_TYPE = 'start' AND B.ACTIVITY_TYPE = 'end' GROUP BY 1;

/*
Prediction Result:
(10, 50.0)
(20, 10.0)
*/