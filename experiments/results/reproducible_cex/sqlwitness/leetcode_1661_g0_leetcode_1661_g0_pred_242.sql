-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 1), (2, 3, 'end', NULL), (3, 4, 'start', 2), (0, 2, 'start', 0), (3, 0, 'end', 2), (4, 0, 'end', 2), (2, 0, 'start', 3), (2, 2, 'start', 1), (3, 2, 'end', 0), (3, 4, 'end', 2), (3, 3, 'start', 2), (3, 1, 'start', NULL), (1, 4, 'start', 3), (0, 2, 'end', 2), (1, 0, 'end', 4), (2, 4, 'start', 0), (4, 3, 'start', 2), (2, 0, 'end', 2), (2, 2, 'end', 2), (0, 1, 'start', NULL), (1, 2, 'end', 3), (2, 1, 'start', 4), (0, 3, 'start', 1), (3, 1, 'end', NULL), (3, 3, 'end', 3), (1, 3, 'start', 2), (2, 4, 'end', 4), (2, 3, 'start', 4), (1, 1, 'start', 3), (3, 0, 'start', NULL), (2, 1, 'end', 2), (4, 0, 'start', 0), (1, 3, 'end', 0), (4, 4, 'start', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(0, 2.0)
(1, -2.0)
(2, 0.5)
(3, 0.0)
(4, 2.0)
*/

-- Prediction Query
SELECT E.MACHINE_ID, ROUND((CAST(SUM(E.TIMESTAMP - S.TIMESTAMP) AS REAL) / COUNT(*)), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS S JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID GROUP BY E.MACHINE_ID;

/*
Prediction Result:
(0, 2.0)
(1, -2.0)
(2, 0.4)
(3, 0.0)
(4, 2.0)
*/