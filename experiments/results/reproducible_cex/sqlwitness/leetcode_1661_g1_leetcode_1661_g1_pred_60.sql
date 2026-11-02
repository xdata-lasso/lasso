-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 4), (2, 3, 'end', 1), (3, 4, 'start', 4), (3, 0, 'end', 0), (2, 2, 'start', NULL), (3, 2, 'end', 1), (3, 4, 'end', 3), (3, 3, 'start', 2), (3, 1, 'start', 3), (0, 2, 'end', 3), (4, 1, 'start', 4), (0, 4, 'end', 4), (4, 3, 'start', NULL), (2, 2, 'end', 4), (0, 3, 'start', 0), (3, 1, 'end', 2), (3, 3, 'end', 1), (2, 4, 'end', NULL), (3, 0, 'start', NULL), (0, 1, 'end', 3), (4, 0, 'start', 0), (4, 2, 'start', 2), (4, 4, 'start', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(2, None)
(3, -1.2)
*/

-- Prediction Query
SELECT A.MACHINE_ID, ROUND(CAST(SUM(B.END - A.START) AS REAL) / COUNT(B.END - A.START), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS START FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS A INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS END FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS B ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID GROUP BY A.MACHINE_ID;

/*
Prediction Result:
(2, None)
(3, -1.5)
*/