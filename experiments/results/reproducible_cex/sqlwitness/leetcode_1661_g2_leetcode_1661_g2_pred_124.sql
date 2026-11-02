-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'start', 1), (3, 2, 'start', 0), (2, 3, 'end', 4), (3, 2, 'end', 2), (3, 4, 'end', 0), (0, 1, 'start', 1), (3, 3, 'start', 4), (3, 1, 'start', 1), (4, 0, 'start', 2), (1, 0, 'start', 0), (3, 3, 'end', NULL), (0, 3, 'end', 1), (4, 2, 'start', 3), (0, 4, 'end', 2), (2, 0, 'start', 2), (4, 4, 'end', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(2, 3.0)
(3, 1.0)
*/

-- Prediction Query
WITH CTE AS (SELECT A1.MACHINE_ID, A1.PROCESS_ID, (A2.TIMESTAMP - A1.TIMESTAMP) AS DURATION FROM ACTIVITY AS A1 CROSS JOIN ACTIVITY AS A2 WHERE A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID, A1.PROCESS_ID) SELECT MACHINE_ID, ROUND(AVG(DURATION), 3) AS PROCESSING_TIME FROM CTE GROUP BY MACHINE_ID ORDER BY MACHINE_ID ASC, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(2, 3.0)
(3, 2.0)
*/