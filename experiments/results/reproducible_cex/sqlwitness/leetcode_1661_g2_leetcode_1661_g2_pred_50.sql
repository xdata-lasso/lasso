-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 2), (2, 3, 'end', 3), (3, 4, 'start', 3), (3, 0, 'end', 2), (0, 4, 'start', NULL), (2, 0, 'start', 3), (4, 4, 'end', 4), (3, 2, 'end', 0), (3, 4, 'end', 0), (3, 3, 'start', 2), (0, 0, 'end', 2), (1, 4, 'start', 1), (3, 1, 'start', 4), (1, 0, 'end', 4), (4, 1, 'start', 1), (0, 4, 'end', NULL), (2, 0, 'end', 0), (2, 2, 'end', NULL), (2, 1, 'start', 0), (1, 2, 'end', 2), (0, 3, 'start', 0), (3, 1, 'end', NULL), (1, 4, 'end', 1), (3, 3, 'end', 1), (2, 4, 'end', 0), (2, 3, 'start', 3), (3, 0, 'start', 4), (2, 1, 'end', NULL), (4, 0, 'start', 3), (4, 2, 'start', 0), (1, 3, 'end', NULL), (4, 4, 'start', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(0, None)
(1, 0.0)
(2, -1.0)
(3, -1.6)
(4, 4.0)
*/

-- Prediction Query
WITH START_TIME AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start' GROUP BY MACHINE_ID, PROCESS_ID ORDER BY MACHINE_ID, PROCESS_ID NULLS LAST, TIMESTAMP NULLS LAST), END_TIME AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end' GROUP BY MACHINE_ID, PROCESS_ID ORDER BY MACHINE_ID, PROCESS_ID NULLS LAST, TIMESTAMP NULLS LAST), DURATION AS (SELECT S.MACHINE_ID, ROUND(E.TIMESTAMP - S.TIMESTAMP, 3) AS DURATIONS FROM START_TIME AS S JOIN END_TIME AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID) SELECT MACHINE_ID, ROUND(AVG(DURATIONS), 3) AS PROCESSING_TIME FROM DURATION GROUP BY MACHINE_ID ORDER BY MACHINE_ID, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(0, None)
(1, 0.0)
(2, -1.5)
(3, -2.0)
(4, 4.0)
*/