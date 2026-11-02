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

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483632, 'b_s_7ed73b', 328.996339);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483631, 'a_s_b4a953', 906.21648);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483630, 'a_s_2ce648', 483.665643);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483629, 'a_s_fa26a7', 818.685402);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483628, 'end', 804.971537);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483627, 'act_d0588c', 119.752245);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (-2147483645, -2147483626, 'b_s_7ed73b', 134.487977);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483625, 'start', 941.961117);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483624, 'start', 4.751658);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483623, 'start', 441.165949);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483622, 'end', 797.015047);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.MACHINE_ID, ROUND(AVG(B.TIMESTAMP - A.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS A CROSS JOIN ACTIVITY AS B WHERE A.MACHINE_ID = B.MACHINE_ID AND B.ACTIVITY_TYPE = 'end' AND A.ACTIVITY_TYPE = 'start' GROUP BY 1;

/*
Prediction Result:
(1, 34.655)
*/