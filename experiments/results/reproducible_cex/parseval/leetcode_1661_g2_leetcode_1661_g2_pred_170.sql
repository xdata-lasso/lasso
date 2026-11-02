-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'a1__031b8a', 582.588439);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'a1__5636bc', 680.190136);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'a1__e4cb2d', 487.053947);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'a2__ede56e', 486.033807);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'a2__ad5bd8', 345.329712);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (3, 1, 'a1__031b8a', 833.684115);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (3, 1, 'a1__5636bc', 261.897639);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (3, 1, 'a1__e4cb2d', 97.952323);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (2, 1, 'a2__ede56e', 171.746906);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 3, 'a1__031b8a', 557.512061);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 4, 'a1__5636bc', 868.436572);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 5, 'a1__e4cb2d', 537.136345);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 2, 'a2__ede56e', 38.937207);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'start', 249.706432);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'act_d0588c', 99.523333);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (4, 1, 'act_d0588c', 314.813297);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TAB1 AS (SELECT MACHINE_ID, PROCESS_ID, MAX(TIMESTAMP) - MIN(TIMESTAMP) AS T FROM ACTIVITY GROUP BY MACHINE_ID, PROCESS_ID) SELECT MACHINE_ID, ROUND(AVG(T), 3) AS PROCESSING_TIME FROM TAB1 GROUP BY MACHINE_ID ORDER BY MACHINE_ID, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(1, 116.133)
(2, 0.0)
(3, 735.732)
(4, 0.0)
*/