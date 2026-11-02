-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1005, 1006, 'start', 1009.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1005, 1009, 'start', 1012.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT TMP.MACHINE_ID AS MACHINE_ID, ROUND(CAST(SUM(TMP.TIME_DIFF) AS REAL) / COUNT(TMP.TIME_DIFF), 3) AS PROCESSING_TIME FROM (SELECT A.MACHINE_ID, ROUND(SUM(CASE WHEN A.ACTIVITY_TYPE = 'end' THEN A.TIMESTAMP ELSE 0 END), 3) - ROUND(SUM(CASE WHEN A.ACTIVITY_TYPE = 'start' THEN A.TIMESTAMP ELSE 0 END), 3) AS TIME_DIFF FROM ACTIVITY AS A GROUP BY A.MACHINE_ID, A.PROCESS_ID) AS TMP GROUP BY TMP.MACHINE_ID;

/*
Prediction Result:
(1005, -1011.0)
*/