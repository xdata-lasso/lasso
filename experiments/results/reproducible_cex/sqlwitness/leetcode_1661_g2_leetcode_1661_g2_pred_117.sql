-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 1), (2, 3, 'end', NULL), (0, 0, 'start', 3), (3, 4, 'start', NULL), (1, 1, 'end', 3), (3, 0, 'end', 4), (4, 0, 'end', 3), (2, 2, 'start', NULL), (3, 2, 'end', NULL), (3, 4, 'end', 0), (3, 3, 'start', NULL), (0, 0, 'end', 0), (0, 2, 'end', 2), (4, 3, 'start', NULL), (2, 0, 'end', 3), (0, 1, 'start', 3), (3, 3, 'end', NULL), (4, 3, 'end', 3), (2, 4, 'end', 0), (1, 1, 'start', 0), (3, 0, 'start', 2), (4, 4, 'start', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(0, -3.0)
(1, 3.0)
(3, 0.5)
(4, None)
*/

-- Prediction Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Prediction Result:
(0, -3.0)
(1, 3.0)
(3, 2.0)
(4, None)
*/