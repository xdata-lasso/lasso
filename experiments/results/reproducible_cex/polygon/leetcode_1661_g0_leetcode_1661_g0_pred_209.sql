-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (60, 9, 'end', -160);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (61, 8, 'end', -146);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(T2 - T1), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, MIN(TIMESTAMP) AS T1, MAX(TIMESTAMP) AS T2 FROM ACTIVITY GROUP BY 1, 2) AS A GROUP BY 1;

/*
Prediction Result:
(60, 0.0)
(61, 0.0)
*/