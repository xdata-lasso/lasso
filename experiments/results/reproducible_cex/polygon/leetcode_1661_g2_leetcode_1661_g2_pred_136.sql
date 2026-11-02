-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (9, 9, 'end', -178);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (8, 9, 'end', -752);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT MACHINE_ID, TIMESTAMP, CASE WHEN ACTIVITY_TYPE = 'start' THEN -1 ELSE 1 END AS TYPE FROM ACTIVITY) SELECT MACHINE_ID, ROUND(AVG(TIMESTAMP * TYPE) * 2, 3) AS PROCESSING_TIME FROM TEMP GROUP BY MACHINE_ID;

/*
Prediction Result:
(8, -1504.0)
(9, -356.0)
*/