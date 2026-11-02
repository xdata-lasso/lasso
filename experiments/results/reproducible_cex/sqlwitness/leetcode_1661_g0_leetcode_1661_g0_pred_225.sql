-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 3, 'start', 1), (0, 4, 'start', 4), (3, 3, 'end', 2), (4, 2, 'start', 2), (2, 0, 'end', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(3, 1.0)
*/

-- Prediction Query
WITH CTE AS (SELECT MACHINE_ID, PROCESS_ID, MAX(CASE WHEN ACTIVITY_TYPE = 'start' THEN TIMESTAMP END) AS START, MAX(CASE WHEN ACTIVITY_TYPE = 'end' THEN TIMESTAMP END) AS END FROM ACTIVITY GROUP BY MACHINE_ID, PROCESS_ID) SELECT MACHINE_ID, ROUND(AVG(END - START), 3) AS PROCESSING_TIME FROM CTE GROUP BY MACHINE_ID;

/*
Prediction Result:
(0, None)
(2, None)
(3, 1.0)
(4, None)
*/