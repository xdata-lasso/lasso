-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 2), (2, 3, 'end', 2), (3, 4, 'start', 3), (0, 2, 'start', 4), (3, 0, 'end', 4), (0, 4, 'start', 4), (3, 2, 'end', 0), (3, 4, 'end', NULL), (1, 2, 'start', 3), (3, 3, 'start', 0), (0, 0, 'end', 3), (3, 1, 'start', NULL), (4, 3, 'start', 4), (2, 0, 'end', NULL), (2, 1, 'start', 0), (3, 1, 'end', 0), (3, 3, 'end', 1), (3, 0, 'start', 4), (1, 3, 'end', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(3, -0.333)
*/

-- Prediction Query
WITH A AS (SELECT A1.MACHINE_ID, A1.PROCESS_ID, (A2.TIMESTAMP - A1.TIMESTAMP) AS COUNT_TIME FROM ACTIVITY AS A1 CROSS JOIN ACTIVITY AS A2 WHERE A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end') SELECT MACHINE_ID, ROUND(CAST(SUM(COUNT_TIME) AS REAL) / COUNT(PROCESS_ID), 3) AS PROCESSING_TIME FROM A GROUP BY MACHINE_ID;

/*
Prediction Result:
(3, -0.2)
*/