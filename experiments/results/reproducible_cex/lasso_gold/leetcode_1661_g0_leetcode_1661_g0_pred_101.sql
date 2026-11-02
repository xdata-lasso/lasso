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
SELECT MACHINE_ID, ROUND(CAST(SUM(END - START) AS REAL) / COUNT(MACHINE_ID), 3) AS PROCESSING_TIME FROM (SELECT DISTINCT MACHINE_ID, PROCESS_ID, (SELECT TIMESTAMP FROM ACTIVITY AS B WHERE B.MACHINE_ID = A.MACHINE_ID AND B.PROCESS_ID = A.PROCESS_ID AND B.ACTIVITY_TYPE = 'start') AS START, (SELECT TIMESTAMP FROM ACTIVITY AS C WHERE C.MACHINE_ID = A.MACHINE_ID AND C.PROCESS_ID = A.PROCESS_ID AND C.ACTIVITY_TYPE = 'end') AS END FROM ACTIVITY AS A) AS T GROUP BY MACHINE_ID;

/*
Prediction Result:
(1005, None)
*/