-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483648, 'start', 582.588439);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483647, 'start', 680.190136);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483646, 'start', 487.053947);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483645, 'end', 486.033807);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483644, 'start', 345.329712);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483643, 'start', 833.684115);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483642, 'start', 261.897639);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483641, 'end', 97.952323);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483640, 'end', 171.746906);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (2, -2147483639, 'start', 557.512061);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (2, -2147483638, 'start', 868.436572);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (2, -2147483637, 'start', 537.136345);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (3, -2147483636, 'end', 38.937207);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483635, 'start', 249.706432);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483634, 'start', 99.523333);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483633, 'start', 314.813297);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483632, 'b_s_f6447c', 328.996339);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483631, 'a_s_2408e0', 906.21648);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483630, 'a_s_9432f2', 483.665643);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483629, 'a_s_352e32', 818.685402);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483628, 'end', 804.971537);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483627, 'start', 119.752245);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483626, 'start', 134.487977);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483625, 'start', 941.961117);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483624, 'end', 4.751658);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.MACHINE_ID, ROUND(AVG(B.TIMESTAMP - A.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS A CROSS JOIN ACTIVITY AS B WHERE A.MACHINE_ID = B.MACHINE_ID AND B.ACTIVITY_TYPE = 'end' AND A.ACTIVITY_TYPE = 'start' GROUP BY 1;

/*
Prediction Result:
(1, -107.824)
*/