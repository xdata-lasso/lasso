-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', NULL), (3, 2, 'end', 1), (0, 0, 'start', 4), (3, 4, 'start', 0), (3, 4, 'end', 4), (0, 1, 'start', 2), (1, 2, 'end', 2), (3, 3, 'start', 2), (0, 0, 'end', 0), (3, 3, 'end', 0), (4, 2, 'end', 3), (2, 0, 'start', 2), (4, 4, 'start', 0), (2, 2, 'start', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, -4.0)
(3, 0.667)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(DIFF), 3) AS PROCESSING_TIME FROM (SELECT DISTINCT A.MACHINE_ID, A.PROCESS_ID, B.TIMESTAMP - A.TIMESTAMP AS DIFF FROM ACTIVITY AS A JOIN ACTIVITY AS B USING (MACHINE_ID, PROCESS_ID) WHERE A.ACTIVITY_TYPE = 'start' AND B.ACTIVITY_TYPE = 'end') AS PP GROUP BY MACHINE_ID;

/*
Prediction Result:
(0, -4.0)
(3, 1.0)
*/