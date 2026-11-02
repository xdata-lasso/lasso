-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'end', 3), (0, 0, 'start', 2), (1, 1, 'start', 2), (3, 4, 'end', 2), (1, 2, 'start', 1), (3, 0, 'start', NULL), (3, 0, 'end', 0), (2, 1, 'end', 0), (0, 3, 'start', NULL), (2, 1, 'start', 0), (0, 2, 'start', 1), (3, 1, 'end', NULL), (3, 3, 'start', 1), (1, 0, 'start', 3), (3, 3, 'end', 4), (1, 3, 'start', 3), (4, 4, 'start', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(2, 0.0)
(3, 1.5)
*/

-- Prediction Query
SELECT T.MACHINE_ID, ROUND(AVG(DIFF), 3) AS PROCESSING_TIME FROM (SELECT A1.MACHINE_ID, (A2.TIMESTAMP - A1.TIMESTAMP) AS DIFF FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID WHERE A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end') AS T GROUP BY T.MACHINE_ID;

/*
Prediction Result:
(2, 0.0)
(3, 3.0)
*/