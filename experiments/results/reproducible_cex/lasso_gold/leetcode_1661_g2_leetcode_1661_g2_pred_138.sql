-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1001, 1002, 'end', 1003.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1001, 1002, 'start', 1004.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1001, -1.0)
*/

-- Prediction Query
WITH X AS (SELECT MACHINE_ID, ROUND(CAST(SUM(TOTAL) AS REAL) / COUNT(MACHINE_ID), 3) AS PROCESSING_TIME FROM (SELECT S.MACHINE_ID, S.PROCESS_ID, ABS(S.TIMESTAMP - E.TIMESTAMP) AS TOTAL FROM ACTIVITY AS S INNER JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND E.PROCESS_ID = S.PROCESS_ID WHERE S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end') AS P GROUP BY MACHINE_ID) SELECT * FROM X;

/*
Prediction Result:
(1001, 1.0)
*/