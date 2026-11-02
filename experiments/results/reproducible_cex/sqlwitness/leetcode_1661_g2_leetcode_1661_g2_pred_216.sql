-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 3), (1, 1, 'end', 3), (1, 2, 'end', NULL), (0, 2, 'start', 2), (2, 1, 'start', 4), (3, 1, 'start', NULL), (3, 0, 'start', 0), (0, 4, 'start', NULL), (1, 0, 'start', NULL), (3, 3, 'end', 2), (1, 0, 'end', NULL), (4, 2, 'end', 4), (4, 3, 'end', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 0.0)
*/

-- Prediction Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(A1.PROCESS_ID), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 CROSS JOIN ACTIVITY AS A2 WHERE A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A2.TIMESTAMP > A1.TIMESTAMP GROUP BY 1;

/*
Prediction Result:
*/