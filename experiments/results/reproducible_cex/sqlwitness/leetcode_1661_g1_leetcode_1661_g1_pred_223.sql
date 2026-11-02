-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'end', 1), (0, 0, 'start', 4), (1, 1, 'end', 1), (3, 0, 'end', 3), (0, 4, 'start', 4), (1, 0, 'start', 4), (4, 0, 'end', 0), (2, 2, 'start', 2), (3, 4, 'end', 0), (1, 2, 'start', 2), (0, 0, 'end', 4), (1, 4, 'start', 3), (1, 0, 'end', 1), (0, 4, 'end', 4), (2, 2, 'end', NULL), (0, 1, 'start', 1), (1, 2, 'end', NULL), (0, 3, 'start', 1), (3, 1, 'end', 3), (1, 4, 'end', 0), (3, 3, 'end', NULL), (1, 3, 'start', 1), (2, 4, 'end', 1), (1, 1, 'start', 0), (2, 1, 'end', 2), (0, 1, 'end', 0), (0, 3, 'end', 0), (1, 3, 'end', NULL), (4, 4, 'start', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, -0.5)
(1, -1.0)
(2, None)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(PROCESS_TIME), 3) AS PROCESSING_TIME FROM (SELECT A.MACHINE_ID, A.PROCESS_ID, (A.TIMESTAMP - B.TIMESTAMP) AS PROCESS_TIME FROM ACTIVITY AS A JOIN ACTIVITY AS B ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID WHERE A.ACTIVITY_TYPE = 'end' AND B.ACTIVITY_TYPE = 'start' GROUP BY 1, 2) AS SUB GROUP BY 1;

/*
Prediction Result:
(0, -0.5)
(1, -1.667)
(2, None)
*/