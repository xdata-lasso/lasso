-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 10, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 10, 'end', 4.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 20, 'start', 2.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 30, 'end', 9.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 10, 'pause', 2.5);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 10, 'start', 0.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 10, 'end', 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(1, 3.0)
*/

-- Prediction Query
WITH TMP AS (SELECT A1.MACHINE_ID, A1.PROCESS_ID, A2.TIMESTAMP - A1.TIMESTAMP AS CON FROM ACTIVITY AS A1 INNER JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE <> A2.ACTIVITY_TYPE WHERE A1.ACTIVITY_TYPE = 'start') SELECT MACHINE_ID, ROUND(AVG(CON), 3) AS PROCESSING_TIME FROM TMP GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, 2.25)
*/