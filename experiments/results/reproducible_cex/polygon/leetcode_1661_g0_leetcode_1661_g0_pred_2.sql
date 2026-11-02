-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (61, 62, 'start', 850);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (61, 10, 'end', 1790);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT E.MACHINE_ID, ROUND(CAST(SUM(E.TIMESTAMP - S.TIMESTAMP) AS REAL) / COUNT(E.PROCESS_ID), 3) AS PROCESSING_TIME FROM ACTIVITY AS E CROSS JOIN ACTIVITY AS S WHERE E.ACTIVITY_TYPE = 'end' AND S.ACTIVITY_TYPE = 'start' AND E.MACHINE_ID = S.MACHINE_ID GROUP BY E.MACHINE_ID;

/*
Prediction Result:
(61, 940.0)
*/