-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'start', 0.0);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'end', 10.0);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 2, 'start', NULL);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 2, 'end', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 5.0)
*/

-- Prediction Query
WITH T1 AS (SELECT MACHINE_ID, PROCESS_ID, START_TIME, END_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS START_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS CTE1 JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS END_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS CTE2 USING (MACHINE_ID, PROCESS_ID)) SELECT MACHINE_ID, ROUND(AVG(END_TIME - START_TIME), 3) AS PROCESSING_TIME FROM T1 WHERE NOT END_TIME IS NULL GROUP BY MACHINE_ID ORDER BY MACHINE_ID, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(1, 10.0)
*/