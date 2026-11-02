-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 1), (3, 2, 'end', 3), (0, 1, 'start', 3), (1, 2, 'start', 1), (3, 0, 'start', 2), (2, 1, 'start', 4), (3, 0, 'end', 1), (0, 0, 'end', NULL), (1, 4, 'start', NULL), (3, 3, 'start', NULL), (0, 4, 'start', 4), (4, 0, 'start', 1), (3, 3, 'end', 0), (4, 1, 'end', 0), (4, 2, 'start', 0), (4, 2, 'end', 3), (2, 0, 'end', NULL), (4, 4, 'start', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(3, 0.333)
(4, 3.0)
*/

-- Prediction Query
WITH STARTS AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS START_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start'), ENDS AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS END_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') SELECT MACHINE_ID, ROUND(AVG(END_TIME - START_TIME), 3) AS PROCESSING_TIME FROM STARTS JOIN ENDS USING (MACHINE_ID, PROCESS_ID) GROUP BY MACHINE_ID;

/*
Prediction Result:
(3, 0.5)
(4, 3.0)
*/