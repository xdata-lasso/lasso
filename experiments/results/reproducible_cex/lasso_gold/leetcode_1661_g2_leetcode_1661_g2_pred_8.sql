-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1015, 1016, 'start', 1017.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1015, 1016, 'end', 1018.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1019, 1020, 'start', NULL);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1019, 1020, 'end', NULL);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1019, 1023, 'start', 1024.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1019, 1023, 'end', 1025.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1015, 1.0)
(1019, 0.5)
*/

-- Prediction Query
SELECT A1.MACHINE_ID, (ROUND(AVG(A2.TIMESTAMP - A1.TIMESTAMP), 3)) AS PROCESSING_TIME FROM ACTIVITY AS A1 CROSS JOIN ACTIVITY AS A2 WHERE A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Prediction Result:
(1015, 1.0)
(1019, 1.0)
*/