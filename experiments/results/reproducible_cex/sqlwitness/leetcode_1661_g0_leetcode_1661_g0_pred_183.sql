-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 1), (0, 0, 'start', 3), (0, 1, 'start', 0), (2, 1, 'start', 2), (0, 2, 'start', NULL), (3, 3, 'start', NULL), (0, 1, 'end', 1), (4, 0, 'start', NULL), (0, 2, 'end', NULL), (3, 3, 'end', 4), (4, 2, 'start', 3), (4, 2, 'end', NULL), (4, 3, 'start', 0), (1, 3, 'start', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(0, 1.0)
(3, None)
(4, None)
*/

-- Prediction Query
WITH TB AS (SELECT S.MACHINE_ID, S.PROCESS_ID, (E.TIMESTAMP - S.TIMESTAMP) AS T FROM (SELECT * FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS S JOIN (SELECT * FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS E USING (MACHINE_ID, PROCESS_ID)) SELECT MACHINE_ID, ROUND(CAST(SUM(T) AS REAL) / COUNT(PROCESS_ID), 3) AS PROCESSING_TIME FROM TB GROUP BY MACHINE_ID;

/*
Prediction Result:
(0, 0.5)
(3, None)
(4, None)
*/