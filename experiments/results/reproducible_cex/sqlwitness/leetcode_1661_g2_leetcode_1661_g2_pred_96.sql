-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', NULL), (2, 3, 'end', 0), (0, 0, 'start', 2), (3, 4, 'start', 1), (3, 0, 'end', 3), (4, 0, 'end', 0), (1, 0, 'start', 1), (2, 2, 'start', 3), (3, 2, 'end', 4), (3, 4, 'end', 0), (3, 3, 'start', 4), (3, 1, 'start', 3), (0, 2, 'end', NULL), (4, 1, 'start', 1), (0, 4, 'end', 1), (2, 0, 'end', 1), (2, 2, 'end', 0), (3, 1, 'end', 2), (3, 3, 'end', 1), (4, 1, 'end', 3), (2, 4, 'end', 4), (2, 3, 'start', 4), (3, 0, 'start', NULL), (4, 0, 'start', 3), (0, 3, 'end', 1), (4, 2, 'start', 1), (4, 4, 'start', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(2, -3.5)
(3, -1.0)
(4, -0.5)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(TP), 3) AS PROCESSING_TIME FROM (SELECT A.MACHINE_ID, A.TIMESTAMP - B.TIMESTAMP AS TP FROM ACTIVITY AS A CROSS JOIN ACTIVITY AS B WHERE A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID AND A.ACTIVITY_TYPE = 'end' AND B.ACTIVITY_TYPE = 'start') AS T GROUP BY MACHINE_ID;

/*
Prediction Result:
(2, -3.5)
(3, -1.667)
(4, -0.5)
*/