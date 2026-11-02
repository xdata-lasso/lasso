-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'end', 4), (3, 2, 'start', NULL), (3, 2, 'end', 3), (3, 4, 'start', 1), (3, 4, 'end', 3), (3, 3, 'start', 3), (3, 1, 'end', NULL), (1, 4, 'end', NULL), (4, 0, 'start', 3), (3, 3, 'end', 2), (0, 3, 'end', 2), (0, 4, 'end', 4), (4, 3, 'end', NULL), (4, 4, 'start', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(3, 0.333)
*/

-- Prediction Query
SELECT ST.MACHINE_ID AS MACHINE_ID, ROUND(AVG(EN.TIMESTAMP - ST.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS ST JOIN ACTIVITY AS EN ON ST.ACTIVITY_TYPE = 'start' AND EN.ACTIVITY_TYPE = 'end' AND ST.PROCESS_ID = EN.PROCESS_ID AND ST.MACHINE_ID = EN.MACHINE_ID GROUP BY ST.MACHINE_ID;

/*
Prediction Result:
(3, 0.5)
*/