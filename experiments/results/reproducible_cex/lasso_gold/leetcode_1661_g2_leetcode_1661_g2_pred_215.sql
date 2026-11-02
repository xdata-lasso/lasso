-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1015, 1016, 'start', 1017.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1015, 1016, 'end', 1018.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1019, 1020, 'start', NULL);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1019, 1020, 'end', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1015, 1.0)
(1019, None)
*/

-- Prediction Query
WITH START AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS START_TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start'), END AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS END_TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end'), TEMP AS (SELECT START.MACHINE_ID, (END_TIMESTAMP - START_TIMESTAMP) AS TIMES FROM START JOIN END ON START.MACHINE_ID = END.MACHINE_ID AND START.PROCESS_ID = END.PROCESS_ID) SELECT MACHINE_ID, COALESCE(ROUND(AVG(TIMES), 3), 0) AS PROCESSING_TIME FROM TEMP GROUP BY MACHINE_ID;

/*
Prediction Result:
(1015, 1.0)
(1019, 0)
*/