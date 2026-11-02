-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 3), (2, 3, 'end', 1), (3, 4, 'start', 2), (1, 1, 'end', 3), (0, 4, 'start', 4), (4, 2, 'end', NULL), (2, 0, 'start', 4), (3, 2, 'end', 1), (3, 4, 'end', 1), (3, 3, 'start', 3), (4, 1, 'start', 2), (2, 4, 'start', 0), (0, 4, 'end', NULL), (2, 2, 'end', 4), (1, 2, 'end', 3), (3, 3, 'end', NULL), (2, 4, 'end', NULL), (3, 0, 'start', NULL), (2, 1, 'end', 1), (0, 1, 'end', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(0, None)
(2, None)
(3, -1.0)
*/

-- Prediction Query
SELECT E.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS E JOIN ACTIVITY AS S ON E.MACHINE_ID = S.MACHINE_ID AND E.PROCESS_ID = S.PROCESS_ID AND E.ACTIVITY_TYPE = 'end' AND S.ACTIVITY_TYPE = 'start' GROUP BY E.MACHINE_ID;

/*
Prediction Result:
(0, None)
(2, None)
(3, -1.5)
*/