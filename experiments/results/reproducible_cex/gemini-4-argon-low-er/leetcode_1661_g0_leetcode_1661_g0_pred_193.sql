-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'start', 10.0);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'end', 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1, 20.0)
*/

-- Prediction Query
WITH NEW AS (SELECT MACHINE_ID, PROCESS_ID, LAG(TIMESTAMP, 1) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY ACTIVITY_TYPE) AS START, TIMESTAMP FROM ACTIVITY) SELECT MACHINE_ID, ROUND(AVG(TIMESTAMP - START), 3) AS PROCESSING_TIME FROM NEW WHERE NOT START IS NULL GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, -20.0)
*/