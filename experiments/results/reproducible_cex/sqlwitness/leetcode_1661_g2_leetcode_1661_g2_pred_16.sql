-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'end', -1), (0, 0, 'start', NULL), (3, -1, 'end', NULL), (3, 4, 'start', NULL), (1, 1, 'end', 4), (-1, -1, 'start', 3), (0, -1, 'end', 4), (2, 0, 'start', 3), (0, 0, 'end', 3), (1, 4, 'start', 3), (0, 2, 'end', 2), (2, 4, 'start', 2), (-1, -1, 'end', 2), (3, 1, 'end', 1), (-1, 2, 'end', 1), (1, 3, 'start', 1), (4, -1, 'start', 2), (2, 4, 'end', 0), (0, 1, 'end', -1), (0, 3, 'end', NULL), (-1, 3, 'start', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(-1, -1.0)
(0, None)
(2, -2.0)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(DUR), 3) AS PROCESSING_TIME FROM (SELECT A1.MACHINE_ID, A1.PROCESS_ID, A2.TIMESTAMP - A1.TIMESTAMP AS DUR FROM ACTIVITY AS A1 CROSS JOIN ACTIVITY AS A2 WHERE A1.ACTIVITY_TYPE <> A2.ACTIVITY_TYPE AND A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID) AS A3 WHERE A3.DUR > 0 GROUP BY 1;

/*
Prediction Result:
(-1, 1.0)
(2, 2.0)
*/