-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (4, 1, 'start', 1), (2, 4, 'end', 2), (2, 4, 'start', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(2, None)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(T), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, LAST_VALUE(TIMESTAMP) OVER W - FIRST_VALUE(TIMESTAMP) OVER W AS T FROM ACTIVITY WINDOW W AS (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY ACTIVITY_TYPE)) AS B GROUP BY MACHINE_ID;

/*
Prediction Result:
(2, 0.0)
(4, 0.0)
*/