-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 3, 'start', NULL), (4, 2, 'start', NULL), (3, 2, 'start', NULL), (3, 3, 'start', 0), (2, 4, 'end', NULL), (1, 2, 'start', 0), (4, 0, 'start', 0), (4, 0, 'end', NULL), (3, 2, 'end', NULL), (2, 0, 'end', 2), (3, 0, 'start', 4), (1, 3, 'end', 1), (0, 4, 'start', NULL), (3, 0, 'end', 1), (2, 2, 'end', 4), (3, 1, 'start', 2), (0, 3, 'end', NULL), (4, 4, 'start', 1), (1, 0, 'start', 3), (2, 3, 'start', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, None)
(3, -1.5)
(4, None)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(PROCESSING_TIME), 3) AS PROCESSING_TIME FROM (SELECT A1.MACHINE_ID, A1.PROCESS_ID, (A2.TIMESTAMP - A1.TIMESTAMP) AS PROCESSING_TIME FROM ACTIVITY AS A1 LEFT OUTER JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID WHERE A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end') AS AA GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, None)
(3, -3.0)
(4, None)
*/