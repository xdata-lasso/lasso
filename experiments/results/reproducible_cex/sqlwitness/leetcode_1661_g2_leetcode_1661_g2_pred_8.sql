-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 3), (3, 4, 'start', 0), (3, 0, 'end', NULL), (3, 2, 'end', 4), (3, 4, 'end', 0), (3, 3, 'start', NULL), (2, 4, 'start', NULL), (0, 4, 'end', 4), (2, 0, 'end', 1), (2, 2, 'end', 0), (2, 1, 'start', 2), (3, 1, 'end', 1), (1, 4, 'end', NULL), (3, 3, 'end', 1), (4, 3, 'end', 2), (3, 0, 'start', NULL), (4, 0, 'start', 4), (4, 2, 'start', 4), (4, 4, 'start', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(3, 0.25)
*/

-- Prediction Query
SELECT A1.MACHINE_ID, (ROUND(AVG(A2.TIMESTAMP - A1.TIMESTAMP), 3)) AS PROCESSING_TIME FROM ACTIVITY AS A1 CROSS JOIN ACTIVITY AS A2 WHERE A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Prediction Result:
(3, 0.5)
*/