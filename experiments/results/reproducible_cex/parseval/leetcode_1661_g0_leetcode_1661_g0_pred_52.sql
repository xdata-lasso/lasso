-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'end', 582.588439);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TBL1 AS (SELECT MACHINE_ID, PROCESS_ID, ACTIVITY_TYPE, LEAD(TIMESTAMP) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY ACTIVITY_TYPE DESC) - TIMESTAMP AS DURATION FROM ACTIVITY), TBL2 AS (SELECT * FROM TBL1 WHERE ACTIVITY_TYPE = 'end') SELECT MACHINE_ID, ROUND(AVG(-1 * DURATION), 3) AS PROCESSING_TIME FROM TBL2 GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, None)
*/