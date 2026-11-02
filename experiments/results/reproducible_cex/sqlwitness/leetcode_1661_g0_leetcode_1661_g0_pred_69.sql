-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 2), (2, 4, 'start', 3), (2, 3, 'start', 4), (4, 1, 'end', 3), (0, 2, 'end', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(DURATION), 3) AS PROCESSING_TIME FROM (SELECT S.MACHINE_ID, S.PROCESS_ID, SUM(CASE WHEN E.ACTIVITY_TYPE = 'end' THEN E.TIMESTAMP END - CASE WHEN S.ACTIVITY_TYPE = 'start' THEN S.TIMESTAMP END) AS DURATION FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID GROUP BY 1, 2) AS A GROUP BY 1 ORDER BY 1, MACHINE_ID NULLS LAST, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(0, None)
(1, None)
(2, None)
(4, None)
*/