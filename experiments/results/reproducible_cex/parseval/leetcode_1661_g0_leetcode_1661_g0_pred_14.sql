-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'e_s_b7d5e2', 582.588439);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 's_s_e6cc11', 680.190136);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 's_s_cb59b2', 487.053947);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 's_s_257060', 486.033807);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'e_s_9f8fb8', 345.329712);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (2, 1, 'e_s_b7d5e2', 833.684115);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (3, 1, 's_s_e6cc11', 261.897639);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (3, 1, 's_s_cb59b2', 97.952323);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (3, 1, 's_s_257060', 171.746906);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 2, 'e_s_b7d5e2', 557.512061);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 3, 's_s_e6cc11', 868.436572);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 4, 's_s_cb59b2', 537.136345);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 5, 's_s_257060', 38.937207);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (4, 1, 'act_d0588c', 249.706432);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'start', 99.523333);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'act_d0588c', 314.813297);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND((CAST(SUM(CASE WHEN ACTIVITY_TYPE = 'start' THEN (-1) * TIMESTAMP ELSE TIMESTAMP END) AS REAL) / (CAST((COUNT(PROCESS_ID)) AS REAL) / 2)), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, 872.456)
(2, 1667.368)
(3, 354.398)
(4, 499.413)
*/