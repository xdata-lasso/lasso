-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 0, 'start', 1), (3, 4, 'start', NULL), (3, 4, 'end', 2), (0, 0, 'end', 4), (3, 1, 'end', 0), (0, -1, 'end', 2), (0, -1, 'start', 1), (0, 1, 'end', 4), (1, 0, 'start', -1), (0, 3, 'end', 1), (4, 1, 'end', 2), (-1, 0, 'end', 4), (2, 4, 'start', 0), (2, 0, 'end', 2), (1, -1, 'start', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(0, 2.0)
(3, None)
*/

-- Prediction Query
WITH START AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS START_TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start'), END AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS END_TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end'), TEMP AS (SELECT START.MACHINE_ID, (END_TIMESTAMP - START_TIMESTAMP) AS TIMES FROM START JOIN END ON START.MACHINE_ID = END.MACHINE_ID AND START.PROCESS_ID = END.PROCESS_ID) SELECT MACHINE_ID, COALESCE(ROUND(AVG(TIMES), 3), 0) AS PROCESSING_TIME FROM TEMP GROUP BY MACHINE_ID;

/*
Prediction Result:
(0, 2.0)
(3, 0)
*/