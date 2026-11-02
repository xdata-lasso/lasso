-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 0), (0, 0, 'start', 4), (3, 0, 'end', 4), (0, 4, 'start', 4), (4, 0, 'end', 3), (3, 2, 'end', 1), (1, 2, 'start', 2), (3, 3, 'start', NULL), (1, 4, 'start', 0), (0, 2, 'end', 3), (2, 4, 'start', 3), (4, 3, 'start', 2), (1, 2, 'end', 1), (0, 3, 'start', NULL), (3, 3, 'end', 0), (4, 1, 'end', 2), (2, 4, 'end', 0), (2, 3, 'start', 1), (1, 1, 'start', 3), (3, 0, 'start', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, -1.0)
(2, -3.0)
(3, 1.333)
*/

-- Prediction Query
SELECT DISTINCT A1.MACHINE_ID, ROUND(AVG(A2.TIMESTAMP - A1.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 CROSS JOIN ACTIVITY AS A2 WHERE A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.TIMESTAMP < A2.TIMESTAMP GROUP BY A1.MACHINE_ID;

/*
Prediction Result:
(1, 1.0)
(2, 3.0)
(3, 2.0)
*/