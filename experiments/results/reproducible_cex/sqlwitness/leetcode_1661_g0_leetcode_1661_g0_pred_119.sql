-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 0, 'start', 2), (1, 2, 'end', 2), (2, 1, 'end', 0), (2, 1, 'start', 2), (0, 3, 'start', NULL), (1, 4, 'start', 2), (3, 0, 'start', 2), (1, 0, 'start', 0), (3, 3, 'end', 3), (0, 3, 'end', NULL), (0, 4, 'end', 2), (2, 0, 'start', 3), (4, 3, 'end', 1), (2, 2, 'start', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(0, None)
(2, -2.0)
*/

-- Prediction Query
SELECT T1.MACHINE_ID, ROUND(AVG(T2.TIMESTAMP - T1.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS T1 JOIN ACTIVITY AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID WHERE T2.TIMESTAMP > T1.TIMESTAMP GROUP BY T1.MACHINE_ID ORDER BY T1.MACHINE_ID, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(2, 2.0)
*/