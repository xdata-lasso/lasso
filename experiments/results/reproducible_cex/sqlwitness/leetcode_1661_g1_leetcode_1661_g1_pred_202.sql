-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 3), (3, 2, 'end', 1), (0, 0, 'start', 1), (3, 4, 'start', NULL), (3, 4, 'end', 1), (1, 2, 'start', 4), (3, 0, 'end', 1), (3, 3, 'start', NULL), (1, 4, 'end', 4), (4, 0, 'start', 1), (0, 2, 'end', 4), (1, 0, 'end', 3), (3, 3, 'end', 0), (4, 1, 'end', 2), (0, 4, 'end', 3), (4, 3, 'start', 2), (1, 3, 'start', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(3, -0.667)
*/

-- Prediction Query
SELECT START.MACHINE_ID, ROUND(AVG(END.TIMESTAMP - START.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS START JOIN ACTIVITY AS END ON START.MACHINE_ID = END.MACHINE_ID AND START.PROCESS_ID = END.PROCESS_ID AND START.ACTIVITY_TYPE = 'start' AND END.ACTIVITY_TYPE = 'end' GROUP BY START.MACHINE_ID;

/*
Prediction Result:
(3, -2.0)
*/