-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'end', 2), (1, 1, 'end', 1), (0, 2, 'start', 4), (4, 0, 'end', 1), (1, 0, 'start', NULL), (2, 0, 'start', 0), (2, 2, 'start', 1), (1, 2, 'start', 1), (0, 2, 'end', 1), (1, 0, 'end', 1), (2, 0, 'end', 1), (1, 2, 'end', NULL), (1, 4, 'end', 4), (1, 3, 'start', NULL), (1, 1, 'start', 0), (2, 1, 'end', NULL), (4, 0, 'start', 0), (0, 3, 'end', 2), (1, 3, 'end', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(0, -3.0)
(1, 1.0)
(2, 1.0)
(4, 1.0)
*/

-- Prediction Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A1.TIMESTAMP - A2.TIMESTAMP) AS REAL) / COUNT(DISTINCT A1.PROCESS_ID), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'end' AND A2.ACTIVITY_TYPE = 'start' GROUP BY 1;

/*
Prediction Result:
(0, -3.0)
(1, 0.25)
(2, 1.0)
(4, 1.0)
*/