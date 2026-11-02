-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'start', 3), (3, 2, 'start', 0), (3, 2, 'end', 3), (1, 1, 'start', 1), (3, 4, 'end', 4), (3, 4, 'start', 1), (1, 2, 'start', NULL), (3, 0, 'start', 4), (3, 3, 'start', NULL), (3, 0, 'end', NULL), (3, 1, 'start', 3), (3, 3, 'end', 2), (4, 1, 'end', 1), (2, 4, 'start', 0), (0, 3, 'end', 3), (2, 0, 'start', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(3, 3.0)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(CAST(SUM(TOTAL_TIME) AS REAL) / COUNT(PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS TOTAL_TIME FROM ACTIVITY AS A1 INNER JOIN ACTIVITY AS A2 USING (MACHINE_ID, PROCESS_ID) WHERE A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY MACHINE_ID, PROCESS_ID) AS T GROUP BY MACHINE_ID;

/*
Prediction Result:
(3, 1.5)
*/