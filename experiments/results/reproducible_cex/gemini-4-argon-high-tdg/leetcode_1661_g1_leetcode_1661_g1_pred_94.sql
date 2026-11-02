-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 1.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 4.500);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'pause', 2.500);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 2.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 3, 'end', 9.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 10.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'end', 15.250);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'start', 20.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'START', 21.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'END', 25.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 1, 'start', 5.000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(1, 3.5)
(2, 5.25)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(PROCESSING), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, ACTIVITY_TYPE, TIMESTAMP - LAG(TIMESTAMP, 1, NULL) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY TIMESTAMP ASC) AS PROCESSING FROM ACTIVITY) AS A WHERE ACTIVITY_TYPE = 'end' GROUP BY 1;

/*
Prediction Result:
(1, 2.0)
(2, 5.25)
*/