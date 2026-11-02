-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 4), (3, 4, 'start', 2), (0, 2, 'start', 2), (3, 0, 'end', 0), (0, 4, 'start', NULL), (4, 0, 'end', 3), (2, 2, 'start', NULL), (3, 2, 'end', NULL), (3, 4, 'end', 0), (3, 3, 'start', NULL), (3, 1, 'start', 2), (2, 2, 'end', 3), (0, 1, 'start', 1), (1, 2, 'end', 0), (0, 3, 'start', 4), (3, 1, 'end', 3), (3, 3, 'end', 2), (4, 3, 'end', 4), (3, 0, 'start', 1), (2, 1, 'end', 4), (4, 0, 'start', 3), (0, 3, 'end', 2), (4, 4, 'start', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, -2.0)
(2, None)
(3, -0.4)
(4, 0.0)
*/

-- Prediction Query
SELECT A.MACHINE_ID, ROUND(AVG(B.ENDTIME - A.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS A JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS ENDTIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS B ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID WHERE A.ACTIVITY_TYPE = 'start' GROUP BY A.MACHINE_ID ORDER BY A.MACHINE_ID, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(0, -2.0)
(2, None)
(3, -0.667)
(4, 0.0)
*/