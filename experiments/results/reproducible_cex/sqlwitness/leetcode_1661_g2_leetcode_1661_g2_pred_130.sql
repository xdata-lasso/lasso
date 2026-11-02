-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 0), (0, 0, 'start', 0), (3, 4, 'start', 2), (3, 0, 'end', 4), (0, 4, 'start', 3), (2, 0, 'start', 3), (4, 4, 'end', NULL), (2, 2, 'start', NULL), (3, 2, 'end', 0), (3, 4, 'end', 4), (1, 2, 'start', 1), (3, 3, 'start', NULL), (3, 1, 'start', 2), (1, 4, 'start', 2), (2, 4, 'start', 0), (4, 3, 'start', 2), (2, 0, 'end', 2), (2, 2, 'end', 4), (3, 1, 'end', NULL), (1, 4, 'end', 2), (3, 3, 'end', 4), (4, 3, 'end', 1), (1, 1, 'start', 0), (3, 0, 'start', 2), (2, 1, 'end', 1), (4, 0, 'start', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 0.0)
(2, -0.5)
(3, 0.8)
(4, -1.0)
*/

-- Prediction Query
WITH E AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS END_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end'), S AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS START_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') SELECT E.MACHINE_ID, ROUND(AVG(E.END_TIME - S.START_TIME), 3) AS PROCESSING_TIME FROM E JOIN S ON E.MACHINE_ID = S.MACHINE_ID AND E.PROCESS_ID = S.PROCESS_ID GROUP BY E.MACHINE_ID;

/*
Prediction Result:
(1, 0.0)
(2, -1.0)
(3, 1.333)
(4, -1.0)
*/