-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'start', 0.0);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'end', 1.0004);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 2, 'start', 0.0);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 2, 'end', 1.0004);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 3, 'start', 0.0);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 3, 'end', 1.0013);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1, 1.001)
*/

-- Prediction Query
WITH START_TIME AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start' GROUP BY MACHINE_ID, PROCESS_ID ORDER BY MACHINE_ID, PROCESS_ID NULLS LAST, TIMESTAMP NULLS LAST), END_TIME AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end' GROUP BY MACHINE_ID, PROCESS_ID ORDER BY MACHINE_ID, PROCESS_ID NULLS LAST, TIMESTAMP NULLS LAST), DURATION AS (SELECT S.MACHINE_ID, ROUND(E.TIMESTAMP - S.TIMESTAMP, 3) AS DURATIONS FROM START_TIME AS S JOIN END_TIME AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID) SELECT MACHINE_ID, ROUND(AVG(DURATIONS), 3) AS PROCESSING_TIME FROM DURATION GROUP BY MACHINE_ID ORDER BY MACHINE_ID, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(1, 1.0)
*/