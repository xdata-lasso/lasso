-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (4, 4, 'start', 1), (3, 0, 'start', 1), (2, 2, 'end', 2), (0, 1, 'end', 3), (1, 3, 'start', 0), (1, 4, 'end', 1), (1, 4, 'start', 4), (3, 3, 'start', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1, -3.0)
*/

-- Prediction Query
WITH N_PROCESS_ID AS (SELECT COUNT(DISTINCT PROCESS_ID) AS COUNT FROM ACTIVITY) SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / (SELECT COUNT FROM N_PROCESS_ID), 3) AS PROCESSING_TIME FROM ACTIVITY AS T1 JOIN ACTIVITY AS T2 ON (T2.MACHINE_ID = T1.MACHINE_ID AND T2.PROCESS_ID = T1.PROCESS_ID) WHERE T1.ACTIVITY_TYPE = 'start' AND T2.ACTIVITY_TYPE = 'end' GROUP BY T1.MACHINE_ID;

/*
Prediction Result:
(1, -0.6)
*/