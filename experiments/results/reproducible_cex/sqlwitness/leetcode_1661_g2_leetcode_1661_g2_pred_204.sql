-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 0, 'end', 1), (3, 4, 'end', 3), (1, 2, 'start', 0), (1, 1, 'start', 0), (3, 4, 'start', 4), (4, 2, 'end', NULL), (4, 0, 'end', NULL), (1, 3, 'start', NULL), (1, 3, 'end', 2), (3, 0, 'start', 3), (0, 2, 'start', 3), (1, 1, 'end', 3), (4, 2, 'start', 2), (4, 4, 'start', 4), (4, 3, 'end', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 1.5)
(3, -1.5)
(4, None)
*/

-- Prediction Query
WITH T1 AS (SELECT MACHINE_ID, PROCESS_ID, START_TIME, END_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS START_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS CTE1 JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS END_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS CTE2 USING (MACHINE_ID, PROCESS_ID)) SELECT MACHINE_ID, ROUND(AVG(END_TIME - START_TIME), 3) AS PROCESSING_TIME FROM T1 WHERE NOT END_TIME IS NULL GROUP BY MACHINE_ID ORDER BY MACHINE_ID, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(1, 3.0)
(3, -1.5)
*/