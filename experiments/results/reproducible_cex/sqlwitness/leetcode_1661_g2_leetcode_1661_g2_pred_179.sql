-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 1), (2, 3, 'end', 0), (0, 0, 'start', 0), (3, 4, 'start', 1), (1, 1, 'end', 4), (3, 0, 'end', 3), (3, 2, 'end', 2), (3, 4, 'end', 3), (1, 2, 'start', 1), (3, 3, 'start', NULL), (3, 1, 'start', 2), (1, 4, 'start', 1), (4, 3, 'start', 4), (2, 0, 'end', NULL), (0, 1, 'start', 2), (3, 1, 'end', NULL), (3, 3, 'end', 2), (4, 1, 'end', 1), (2, 3, 'start', 0), (3, 0, 'start', 1), (0, 1, 'end', 4), (4, 4, 'start', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(0, 2.0)
(2, 0.0)
(3, 1.0)
*/

-- Prediction Query
SELECT ST.MACHINE_ID AS MACHINE_ID, ROUND(AVG(EN.TIMESTAMP - ST.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS ST JOIN ACTIVITY AS EN ON ST.ACTIVITY_TYPE = 'start' AND EN.ACTIVITY_TYPE = 'end' AND ST.PROCESS_ID = EN.PROCESS_ID AND ST.MACHINE_ID = EN.MACHINE_ID GROUP BY ST.MACHINE_ID;

/*
Prediction Result:
(0, 2.0)
(2, 0.0)
(3, 1.667)
*/