-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 2), (3, 4, 'start', 3), (3, 0, 'end', 1), (4, 0, 'end', 0), (2, 0, 'start', 1), (4, 4, 'end', NULL), (2, 2, 'start', 0), (3, 2, 'end', 3), (3, 4, 'end', 3), (1, 2, 'start', 4), (3, 3, 'start', 3), (1, 0, 'end', 3), (2, 2, 'end', 1), (3, 1, 'end', NULL), (1, 4, 'end', 2), (3, 3, 'end', NULL), (4, 1, 'end', 1), (2, 3, 'start', 4), (3, 0, 'start', NULL), (0, 3, 'end', NULL), (1, 3, 'end', 1), (4, 4, 'start', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(2, 1.0)
(3, 0.25)
(4, None)
*/

-- Prediction Query
SELECT ASS.MACHINE_ID, ROUND(AVG(AE.TIMESTAMP - ASS.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS ASS INNER JOIN ACTIVITY AS AE ON ASS.MACHINE_ID = AE.MACHINE_ID AND ASS.PROCESS_ID = AE.PROCESS_ID AND ASS.ACTIVITY_TYPE = 'start' AND AE.ACTIVITY_TYPE = 'end' GROUP BY ASS.MACHINE_ID;

/*
Prediction Result:
(2, 1.0)
(3, 0.5)
(4, None)
*/