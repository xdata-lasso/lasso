-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'start', 0.0);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'end', 2.0);
INSERT INTO "Activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 2, 'start', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 2.0)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(CAST(SUM(END - START) AS REAL) / COUNT(MACHINE_ID), 3) AS PROCESSING_TIME FROM (SELECT DISTINCT MACHINE_ID, PROCESS_ID, (SELECT TIMESTAMP FROM ACTIVITY AS B WHERE B.MACHINE_ID = A.MACHINE_ID AND B.PROCESS_ID = A.PROCESS_ID AND B.ACTIVITY_TYPE = 'start') AS START, (SELECT TIMESTAMP FROM ACTIVITY AS C WHERE C.MACHINE_ID = A.MACHINE_ID AND C.PROCESS_ID = A.PROCESS_ID AND C.ACTIVITY_TYPE = 'end') AS END FROM ACTIVITY AS A) AS T GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, 1.0)
*/