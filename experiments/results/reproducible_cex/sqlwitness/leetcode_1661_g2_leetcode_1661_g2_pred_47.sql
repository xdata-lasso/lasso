-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 0), (3, 0, 'end', 0), (1, 0, 'start', 0), (4, 4, 'end', 0), (3, 4, 'end', 1), (1, 2, 'start', 4), (1, 4, 'start', 4), (1, 0, 'end', 3), (2, 4, 'start', 3), (0, 1, 'start', 0), (1, 2, 'end', 2), (3, 1, 'end', 0), (1, 4, 'end', 1), (3, 3, 'end', 1), (4, 1, 'end', 4), (1, 3, 'start', 4), (1, 1, 'start', 0), (4, 2, 'start', 1), (1, 3, 'end', NULL), (4, 4, 'start', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, -0.4)
(4, -1.0)
*/

-- Prediction Query
WITH PROCESS_TIMES AS (SELECT A1.MACHINE_ID, A1.PROCESS_ID, (A2.TIMESTAMP - A1.TIMESTAMP) AS PROCESS_TIME FROM ACTIVITY AS A1 INNER JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end') SELECT MACHINE_ID, ROUND(AVG(PROCESS_TIME), 3) AS PROCESSING_TIME FROM PROCESS_TIMES GROUP BY 1 ORDER BY 1, MACHINE_ID NULLS LAST, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(1, -0.5)
(4, -1.0)
*/