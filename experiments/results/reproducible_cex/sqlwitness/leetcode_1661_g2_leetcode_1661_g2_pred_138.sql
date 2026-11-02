-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'end', 0), (3, 2, 'end', 1), (0, 0, 'start', NULL), (3, 4, 'start', 2), (1, 2, 'end', NULL), (2, 1, 'end', 1), (3, 3, 'start', 2), (0, 0, 'end', 0), (3, 1, 'end', NULL), (0, 2, 'end', 4), (4, 0, 'end', NULL), (3, 3, 'end', 1), (4, 1, 'end', 3), (4, 2, 'end', 2), (0, 4, 'end', 2), (2, 0, 'end', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(0, None)
(3, -1.0)
*/

-- Prediction Query
WITH X AS (SELECT MACHINE_ID, ROUND(CAST(SUM(TOTAL) AS REAL) / COUNT(MACHINE_ID), 3) AS PROCESSING_TIME FROM (SELECT S.MACHINE_ID, S.PROCESS_ID, ABS(S.TIMESTAMP - E.TIMESTAMP) AS TOTAL FROM ACTIVITY AS S INNER JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND E.PROCESS_ID = S.PROCESS_ID WHERE S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end') AS P GROUP BY MACHINE_ID) SELECT * FROM X;

/*
Prediction Result:
(0, None)
(3, 1.0)
*/