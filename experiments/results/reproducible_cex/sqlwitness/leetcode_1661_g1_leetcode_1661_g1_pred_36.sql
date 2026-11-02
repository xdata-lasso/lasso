-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', NULL), (2, 3, 'end', 1), (3, 4, 'start', 3), (0, 2, 'start', 0), (3, 0, 'end', 0), (1, 0, 'start', 3), (4, 0, 'end', 3), (3, 2, 'end', 4), (3, 4, 'end', 1), (3, 3, 'start', 2), (4, 1, 'start', 1), (2, 4, 'start', 1), (1, 2, 'end', 3), (3, 3, 'end', NULL), (1, 3, 'start', 1), (4, 3, 'end', 2), (1, 1, 'start', 3), (3, 0, 'start', NULL), (2, 1, 'end', 1), (4, 0, 'start', 1), (4, 2, 'start', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(3, -0.5)
(4, 2.0)
*/

-- Prediction Query
SELECT A.MACHINE_ID, ROUND(AVG(A.TIMESTAMP - B.TIMESTAMP), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end' GROUP BY MACHINE_ID, PROCESS_ID) AS A JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start' GROUP BY MACHINE_ID, PROCESS_ID) AS B ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID GROUP BY A.MACHINE_ID;

/*
Prediction Result:
(3, -2.0)
(4, 2.0)
*/