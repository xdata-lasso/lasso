-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'a1__8cb82e', 582.588439);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'a1__3fd004', 680.190136);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'a1__1228ea', 487.053947);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'a2__7ba17a', 486.033807);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'a2__ef6c99', 345.329712);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (3, 1, 'a1__8cb82e', 833.684115);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (3, 1, 'a1__3fd004', 261.897639);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (3, 1, 'a1__1228ea', 97.952323);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (2, 1, 'a2__7ba17a', 171.746906);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 3, 'a1__8cb82e', 557.512061);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 4, 'a1__3fd004', 868.436572);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 5, 'a1__1228ea', 537.136345);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 2, 'a2__7ba17a', 38.937207);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (4, 1, 'act_d0588c', 249.706432);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'start', 99.523333);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'act_d0588c', 314.813297);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(DURATION), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, SUM(CASE WHEN ACTIVITY_TYPE = 'start' THEN 0 - TIMESTAMP ELSE TIMESTAMP END) AS DURATION FROM ACTIVITY GROUP BY MACHINE_ID, PROCESS_ID) AS T GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, 959.702)
(2, 171.747)
(3, 1193.534)
(4, 249.706)
*/