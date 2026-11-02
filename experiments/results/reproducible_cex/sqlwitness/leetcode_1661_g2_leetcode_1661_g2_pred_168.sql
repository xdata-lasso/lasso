-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', NULL), (3, 2, 'end', 3), (3, 4, 'end', 0), (3, 0, 'start', 1), (3, 3, 'start', 2), (2, 1, 'end', 2), (0, 3, 'start', 1), (1, 0, 'end', 2), (3, 3, 'end', 4), (4, 2, 'start', 1), (0, 4, 'end', 3), (4, 3, 'end', 0), (1, 3, 'end', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(3, 1.0)
*/

-- Prediction Query
WITH TMP AS (SELECT A1.MACHINE_ID, A1.PROCESS_ID, A2.TIMESTAMP - A1.TIMESTAMP AS CON FROM ACTIVITY AS A1 INNER JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE <> A2.ACTIVITY_TYPE WHERE A1.ACTIVITY_TYPE = 'start') SELECT MACHINE_ID, ROUND(AVG(CON), 3) AS PROCESSING_TIME FROM TMP GROUP BY MACHINE_ID;

/*
Prediction Result:
(3, 2.0)
*/