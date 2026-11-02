-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1047, 1048, 'end', 1049.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1047, 1048, 'site', 1050.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(PROCESSING), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, ACTIVITY_TYPE, TIMESTAMP - LAG(TIMESTAMP, 1, NULL) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY TIMESTAMP ASC) AS PROCESSING FROM ACTIVITY) AS A WHERE ACTIVITY_TYPE = 'end' GROUP BY 1;

/*
Prediction Result:
(1047, None)
*/