-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 1), (1, 3, 'start', 3), (1, 1, 'start', 4), (3, 0, 'start', NULL), (3, 0, 'end', 2), (3, 3, 'start', 0), (0, 3, 'start', 2), (3, 1, 'end', 3), (3, 1, 'start', 4), (1, 4, 'start', NULL), (3, 3, 'end', 0), (4, 1, 'start', 4), (4, 2, 'start', 2), (0, 4, 'end', NULL), (4, 3, 'start', 0), (2, 0, 'end', 3), (2, 4, 'end', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(3, -0.5)
*/

-- Prediction Query
WITH TD AS (SELECT A1.MACHINE_ID, A1.PROCESS_ID, A1.TIMESTAMP AS START_TS, A2.TIMESTAMP AS END_TS FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end') SELECT MACHINE_ID, ROUND(CAST(SUM(END_TS - START_TS) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM TD GROUP BY MACHINE_ID;

/*
Prediction Result:
(3, -0.333)
*/