-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1005, 1006, 'start', 1009.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1005, 1009, 'start', 1012.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TOTALS AS (SELECT MACHINE_ID, SUM(CASE WHEN ACTIVITY_TYPE = 'start' THEN TIMESTAMP END) AS STARTS, SUM(CASE WHEN ACTIVITY_TYPE = 'end' THEN TIMESTAMP END) AS ENDS, COUNT(DISTINCT PROCESS_ID) AS TOTAL_PROCESSES FROM ACTIVITY GROUP BY 1) SELECT MACHINE_ID, ROUND(CAST((ENDS - STARTS) AS REAL) / TOTAL_PROCESSES, 3) AS PROCESSING_TIME FROM TOTALS GROUP BY 1;

/*
Prediction Result:
(1005, None)
*/