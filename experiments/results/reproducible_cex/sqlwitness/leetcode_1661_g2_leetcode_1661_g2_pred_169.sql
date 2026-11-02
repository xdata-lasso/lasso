-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'end', NULL), (3, 4, 'end', NULL), (1, 0, 'start', 0), (4, 3, 'start', NULL), (3, 2, 'start', 2), (2, 0, 'start', 2), (1, 2, 'end', 0), (1, 0, 'end', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT A.MACHINE_ID, A.PROCESS_ID, (B.TIMESTAMP - A.TIMESTAMP) AS PROCESSING_TIME FROM ACTIVITY AS A INNER JOIN ACTIVITY AS B ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID AND A.TIMESTAMP < B.TIMESTAMP) SELECT MACHINE_ID, ROUND(AVG(PROCESSING_TIME), 3) AS PROCESSING_TIME FROM CTE GROUP BY MACHINE_ID;

/*
Prediction Result:
*/