-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'start', 10.0);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'end', 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1, -5.0)
*/

-- Prediction Query
WITH X AS (SELECT MACHINE_ID, ROUND(CAST(SUM(TOTAL) AS REAL) / COUNT(MACHINE_ID), 3) AS PROCESSING_TIME FROM (SELECT S.MACHINE_ID, S.PROCESS_ID, ABS(S.TIMESTAMP - E.TIMESTAMP) AS TOTAL FROM ACTIVITY AS S INNER JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND E.PROCESS_ID = S.PROCESS_ID WHERE S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end') AS P GROUP BY MACHINE_ID) SELECT * FROM X;

/*
Prediction Result:
(1, 5.0)
*/