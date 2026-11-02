-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'end', 3), (0, 0, 'start', 0), (3, 4, 'end', 4), (1, 1, 'end', 3), (2, 1, 'start', NULL), (3, 0, 'end', 3), (2, 1, 'end', 3), (0, 3, 'start', 3), (0, 0, 'end', 0), (0, 1, 'end', 2), (3, 3, 'end', 3), (2, 4, 'start', 2), (2, 0, 'end', 2), (2, 2, 'start', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(0, 0.0)
(2, 0.5)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(END_TIME - START_TIME), 3) AS PROCESSING_TIME FROM (SELECT A1.MACHINE_ID AS MACHINE_ID, A1.PROCESS_ID AS PROCESS_ID, A1.TIMESTAMP AS START_TIME, A2.TIMESTAMP AS END_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' AND A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID GROUP BY A1.MACHINE_ID, A1.PROCESS_ID) AS T GROUP BY MACHINE_ID;

/*
Prediction Result:
(0, 0.0)
(2, 1.0)
*/