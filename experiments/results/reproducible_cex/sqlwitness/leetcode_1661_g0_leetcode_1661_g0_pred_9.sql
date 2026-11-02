-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 2), (2, 3, 'end', 4), (0, 0, 'start', NULL), (3, 4, 'start', 0), (3, 0, 'end', 3), (4, 0, 'end', 3), (4, 2, 'end', NULL), (2, 0, 'start', NULL), (4, 4, 'end', 2), (2, 2, 'start', 1), (3, 2, 'end', 0), (3, 4, 'end', 2), (1, 2, 'start', 2), (3, 3, 'start', 0), (3, 1, 'start', NULL), (1, 0, 'end', 1), (2, 4, 'start', 1), (2, 0, 'end', 0), (2, 2, 'end', NULL), (2, 1, 'start', 3), (0, 3, 'start', 4), (3, 1, 'end', 1), (3, 3, 'end', 0), (2, 4, 'end', 1), (2, 3, 'start', 2), (1, 1, 'start', 1), (3, 0, 'start', 1), (2, 1, 'end', 2), (0, 1, 'end', 3), (4, 0, 'start', NULL), (4, 2, 'start', NULL), (1, 3, 'end', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(2, 0.333)
(3, 0.5)
(4, None)
*/

-- Prediction Query
SELECT COUNTED.MACHINE_ID, ROUND(CAST(SUM(COUNTED.DIFF) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM (SELECT A.MACHINE_ID, A.PROCESS_ID, A.ACTIVITY_TYPE, (B.TIMESTAMP - A.TIMESTAMP) AS DIFF FROM ACTIVITY AS A CROSS JOIN ACTIVITY AS B WHERE (A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID AND A.ACTIVITY_TYPE = 'start' AND B.ACTIVITY_TYPE = 'end')) AS COUNTED GROUP BY MACHINE_ID;

/*
Prediction Result:
(2, 0.2)
(3, 0.4)
(4, None)
*/