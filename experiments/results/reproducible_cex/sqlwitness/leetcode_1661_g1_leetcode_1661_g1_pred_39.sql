-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 3, 'start', 2), (2, 3, 'end', 0), (3, 2, 'end', 1), (3, 2, 'start', NULL), (0, 0, 'start', NULL), (3, 4, 'start', NULL), (3, 4, 'end', 3), (2, 1, 'start', 4), (2, 1, 'end', 2), (3, 3, 'start', 2), (3, 1, 'start', 3), (3, 0, 'end', 3), (4, 0, 'start', 4), (1, 0, 'end', 0), (3, 3, 'end', 0), (4, 2, 'end', 2), (0, 4, 'end', 2), (4, 3, 'end', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(2, -2.0)
(3, -0.667)
*/

-- Prediction Query
SELECT TEMP.MACHINE_ID, ROUND(AVG(END - BEGIN), 3) AS PROCESSING_TIME FROM (SELECT A.MACHINE_ID, A.TIMESTAMP AS BEGIN, B.TIMESTAMP AS END FROM ACTIVITY AS A CROSS JOIN ACTIVITY AS B WHERE A.ACTIVITY_TYPE = 'start' AND B.ACTIVITY_TYPE = 'end' AND A.PROCESS_ID = B.PROCESS_ID AND A.MACHINE_ID = B.MACHINE_ID) AS TEMP GROUP BY TEMP.MACHINE_ID;

/*
Prediction Result:
(2, -2.0)
(3, -2.0)
*/