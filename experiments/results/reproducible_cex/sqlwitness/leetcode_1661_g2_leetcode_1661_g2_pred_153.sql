-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', NULL), (1, 1, 'start', 3), (1, 1, 'end', 3), (3, 0, 'start', 0), (3, 3, 'start', 3), (3, 0, 'end', 3), (3, 1, 'start', 2), (3, 1, 'end', 2), (1, 4, 'end', 3), (0, 0, 'end', 1), (4, 3, 'end', 0), (3, 3, 'end', NULL), (0, 4, 'end', 3), (4, 3, 'start', 0), (1, 3, 'start', 0), (1, 3, 'end', NULL), (2, 4, 'end', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 0.0)
(3, 1.0)
(4, 0.0)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(PROCESS_TIME), 3) AS PROCESSING_TIME FROM (SELECT E.MACHINE_ID, E.PROCESS_ID, (E.TIMESTAMP - S.TIMESTAMP) AS PROCESS_TIME FROM ACTIVITY AS E JOIN ACTIVITY AS S USING (MACHINE_ID, PROCESS_ID) WHERE E.ACTIVITY_TYPE = 'end' AND S.ACTIVITY_TYPE = 'start') AS PT GROUP BY 1;

/*
Prediction Result:
(1, 0.0)
(3, 1.5)
(4, 0.0)
*/