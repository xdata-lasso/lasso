-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1014, 1015, 'start', 1016.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1014, 1015, 'end', 1017.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1014, 1018, 'start', 1016.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1014, 1019, 'start', 1028.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1014, 1.0)
*/

-- Prediction Query
SELECT E.MACHINE_ID, ROUND(CAST(SUM(E.TIMESTAMP - S.TIMESTAMP) AS REAL) / COUNT(E.PROCESS_ID), 3) AS PROCESSING_TIME FROM ACTIVITY AS E CROSS JOIN ACTIVITY AS S WHERE E.ACTIVITY_TYPE = 'end' AND S.ACTIVITY_TYPE = 'start' AND E.MACHINE_ID = S.MACHINE_ID GROUP BY E.MACHINE_ID;

/*
Prediction Result:
(1014, -3.0)
*/