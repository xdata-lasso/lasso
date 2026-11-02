-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 4), (1, 1, 'start', 0), (1, 1, 'end', 4), (2, 1, 'start', 4), (2, 1, 'end', 2), (0, 3, 'start', 3), (3, 1, 'end', 2), (4, 0, 'end', 3), (1, 0, 'start', 2), (1, 0, 'end', NULL), (0, 3, 'end', 3), (4, 2, 'start', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(0, 0.0)
(1, 2.0)
(2, -2.0)
*/

-- Prediction Query
WITH DIFFERENCES AS (SELECT A1.MACHINE_ID, (A2.TIMESTAMP - A1.TIMESTAMP) AS TIMEDIFFERENCE FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end') SELECT MACHINE_ID, ROUND(AVG(TIMEDIFFERENCE), 3) AS PROCESSING_TIME FROM DIFFERENCES GROUP BY 1;

/*
Prediction Result:
(0, 0.0)
(1, 4.0)
(2, -2.0)
*/