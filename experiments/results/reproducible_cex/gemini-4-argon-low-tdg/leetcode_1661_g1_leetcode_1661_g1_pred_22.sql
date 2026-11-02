-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 2.1234);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 3.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'end', 6.5555);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 3, 'start', 4.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 3, 'end', 5.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 10.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'end', 25.6789);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(1, 1.893)
(2, 15.679)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(T), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, LAST_VALUE(TIMESTAMP) OVER W - FIRST_VALUE(TIMESTAMP) OVER W AS T FROM ACTIVITY WINDOW W AS (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY ACTIVITY_TYPE)) AS B GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, -0.946)
(2, -7.839)
*/