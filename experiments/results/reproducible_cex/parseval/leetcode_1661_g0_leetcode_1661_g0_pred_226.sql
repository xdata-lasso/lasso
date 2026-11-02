-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'e_s_d2792e', 582.588439);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 's_s_a8dbbb', 680.190136);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 's_s_e860a8', 487.053947);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 's_s_1a0aba', 486.033807);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'e_s_f4ad55', 345.329712);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (2, 1, 'e_s_d2792e', 833.684115);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (3, 1, 's_s_a8dbbb', 261.897639);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (3, 1, 's_s_e860a8', 97.952323);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (3, 1, 's_s_1a0aba', 171.746906);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 2, 'e_s_d2792e', 557.512061);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 3, 's_s_a8dbbb', 868.436572);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 4, 's_s_e860a8', 537.136345);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 5, 's_s_1a0aba', 38.937207);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'start', 249.706432);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'act_d0588c', 99.523333);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (4, 1, 'act_d0588c', 314.813297);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(CAST(SUM(DIFFERENCE) AS REAL) / COUNT(DIFFERENCE), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, MAX(TIMESTAMP) - MIN(TIMESTAMP) AS DIFFERENCE FROM ACTIVITY GROUP BY MACHINE_ID, PROCESS_ID) AS TMP GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, 116.133)
(2, 0.0)
(3, 163.945)
(4, 0.0)
*/