-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 0, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 0, 'end', 2.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 1, 'start', 10.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 1, 'end', 11.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 2, 'start', 20.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 2, 'end', 22.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 0, 'start', 0.5);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 0, 'end', 1.5);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 5.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 7.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 12.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'end', 14.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 0, 'start', 0.712);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 0, 'end', 1.52);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 3.14);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'end', 4.66);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(0, 1.333)
(1, 1.667)
(2, 1.164)
*/

-- Prediction Query
WITH N_PROCESS_ID AS (SELECT COUNT(DISTINCT PROCESS_ID) AS COUNT FROM ACTIVITY) SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / (SELECT COUNT FROM N_PROCESS_ID), 3) AS PROCESSING_TIME FROM ACTIVITY AS T1 JOIN ACTIVITY AS T2 ON (T2.MACHINE_ID = T1.MACHINE_ID AND T2.PROCESS_ID = T1.PROCESS_ID) WHERE T1.ACTIVITY_TYPE = 'start' AND T2.ACTIVITY_TYPE = 'end' GROUP BY T1.MACHINE_ID;

/*
Prediction Result:
(0, 1.333)
(1, 1.667)
(2, 0.776)
*/