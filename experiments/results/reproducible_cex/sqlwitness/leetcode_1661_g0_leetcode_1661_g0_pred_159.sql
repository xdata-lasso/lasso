-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'end', 3), (3, 3, 'start', 2), (1, 4, 'start', NULL), (0, 4, 'start', NULL), (3, 3, 'end', 0), (4, 1, 'end', 3), (1, 3, 'end', 0), (4, 4, 'start', 1), (2, 2, 'start', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(3, -2.0)
*/

-- Prediction Query
SELECT T1.MACHINE_ID, ROUND(AVG(T2.TIMESTAMP - T1.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS T1 JOIN ACTIVITY AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID WHERE T1.TIMESTAMP < T2.TIMESTAMP GROUP BY T1.MACHINE_ID;

/*
Prediction Result:
(3, 2.0)
*/