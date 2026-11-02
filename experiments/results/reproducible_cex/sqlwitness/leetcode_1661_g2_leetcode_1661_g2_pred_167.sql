-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 3, 'start', 0), (2, 3, 'end', NULL), (1, 1, 'start', NULL), (1, 1, 'end', 3), (0, 1, 'start', 4), (1, 2, 'end', 0), (3, 0, 'end', 3), (2, 1, 'start', NULL), (0, 3, 'start', 1), (4, 0, 'start', 2), (1, 0, 'start', 3), (1, 0, 'end', 0), (4, 1, 'start', 2), (0, 2, 'end', 0), (4, 1, 'end', 4), (4, 3, 'end', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, -1.5)
(4, 2.0)
*/

-- Prediction Query
WITH START_TIME AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start'), END_TIME AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM START_TIME AS S INNER JOIN END_TIME AS E ON (S.MACHINE_ID, S.PROCESS_ID) = (E.MACHINE_ID, E.PROCESS_ID) GROUP BY 1;

/*
Prediction Result:
(1, -3.0)
(4, 2.0)
*/