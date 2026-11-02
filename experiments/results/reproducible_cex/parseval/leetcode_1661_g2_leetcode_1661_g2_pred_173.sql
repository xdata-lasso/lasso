-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'act_d0588c', 582.588439);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, 1, 'start', 1.0);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483647, 'end', 1.0);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483646, 'end', 1.0);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483645, 'end', 1.0);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483644, 'act_d0588c', 680.190136);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483643, 'act_d0588c', 487.053947);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483642, 'end', 1.0);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483641, 'act_d0588c', 486.033807);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483640, 'act_d0588c', 345.329712);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483639, 'end', 1.0);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483638, 'act_d0588c', 833.684115);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483637, 'act_d0588c', 261.897639);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483636, 'end', 1.0);

INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1, -2147483635, 'end', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT MACHINE_ID, PROCESS_ID FROM ACTIVITY), CTE1 AS (SELECT A.MACHINE_ID, A.TIMESTAMP FROM ACTIVITY AS A CROSS JOIN CTE WHERE A.ACTIVITY_TYPE = 'end' AND A.MACHINE_ID = CTE.MACHINE_ID AND A.PROCESS_ID = CTE.PROCESS_ID), CTE2 AS (SELECT A.MACHINE_ID, A.TIMESTAMP FROM ACTIVITY AS A CROSS JOIN CTE WHERE A.ACTIVITY_TYPE = 'start' AND A.MACHINE_ID = CTE.MACHINE_ID AND A.PROCESS_ID = CTE.PROCESS_ID) SELECT CTE1.MACHINE_ID, ROUND(AVG(CTE1.TIMESTAMP - CTE2.TIMESTAMP), 3) AS PROCESSING_TIME FROM CTE1 JOIN CTE2 ON CTE1.MACHINE_ID = CTE2.MACHINE_ID GROUP BY CTE1.MACHINE_ID;

/*
Prediction Result:
(1, 0.0)
*/