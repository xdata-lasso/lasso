-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 4), (3, 4, 'start', NULL), (3, 0, 'end', NULL), (0, 4, 'start', 4), (4, 0, 'end', 0), (4, 2, 'end', 2), (2, 0, 'start', NULL), (3, 2, 'end', NULL), (3, 4, 'end', 3), (3, 3, 'start', 1), (3, 1, 'start', 1), (0, 2, 'end', 0), (4, 3, 'start', NULL), (2, 2, 'end', 2), (2, 1, 'start', 2), (1, 2, 'end', 0), (0, 3, 'start', NULL), (3, 1, 'end', 3), (1, 4, 'end', 2), (3, 3, 'end', 0), (3, 0, 'start', 4), (1, 3, 'end', 0), (4, 4, 'start', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(3, 0.2)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(DIFF), 3) AS PROCESSING_TIME FROM (SELECT DISTINCT A.MACHINE_ID, A.PROCESS_ID, B.TIMESTAMP - A.TIMESTAMP AS DIFF FROM ACTIVITY AS A JOIN ACTIVITY AS B USING (MACHINE_ID, PROCESS_ID) WHERE A.ACTIVITY_TYPE = 'start' AND B.ACTIVITY_TYPE = 'end') AS PP GROUP BY MACHINE_ID;

/*
Prediction Result:
(3, 0.5)
*/