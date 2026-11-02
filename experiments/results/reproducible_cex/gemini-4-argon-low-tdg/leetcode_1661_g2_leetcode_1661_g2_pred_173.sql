-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 11.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 2.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'end', NULL);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', NULL);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'end', 15.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'start', 5.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'end', 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 5.0)
(2, 10.0)
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT MACHINE_ID, PROCESS_ID FROM ACTIVITY), CTE1 AS (SELECT A.MACHINE_ID, A.TIMESTAMP FROM ACTIVITY AS A CROSS JOIN CTE WHERE A.ACTIVITY_TYPE = 'end' AND A.MACHINE_ID = CTE.MACHINE_ID AND A.PROCESS_ID = CTE.PROCESS_ID), CTE2 AS (SELECT A.MACHINE_ID, A.TIMESTAMP FROM ACTIVITY AS A CROSS JOIN CTE WHERE A.ACTIVITY_TYPE = 'start' AND A.MACHINE_ID = CTE.MACHINE_ID AND A.PROCESS_ID = CTE.PROCESS_ID) SELECT CTE1.MACHINE_ID, ROUND(AVG(CTE1.TIMESTAMP - CTE2.TIMESTAMP), 3) AS PROCESSING_TIME FROM CTE1 JOIN CTE2 ON CTE1.MACHINE_ID = CTE2.MACHINE_ID GROUP BY CTE1.MACHINE_ID;

/*
Prediction Result:
(1, 9.5)
(2, 15.0)
*/