-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'end', 1), (1, 1, 'end', 0), (3, 0, 'end', 4), (0, 4, 'start', 3), (4, 0, 'end', 2), (1, 0, 'start', 1), (4, 2, 'end', 0), (2, 0, 'start', NULL), (3, 2, 'end', 1), (1, 2, 'start', 3), (3, 3, 'start', 0), (0, 0, 'end', 3), (1, 4, 'start', 1), (1, 0, 'end', 0), (4, 1, 'start', 4), (0, 4, 'end', 0), (4, 3, 'start', 0), (2, 0, 'end', 4), (0, 1, 'start', NULL), (2, 1, 'start', 0), (1, 2, 'end', 1), (0, 3, 'start', 1), (3, 3, 'end', NULL), (1, 3, 'start', 1), (2, 4, 'end', 2), (1, 1, 'start', 4), (2, 1, 'end', 3), (0, 1, 'end', 2), (0, 3, 'end', 0), (1, 3, 'end', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(0, -1.333)
(1, -1.75)
(2, 1.5)
(3, None)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(PROCESS_TIME), 3) AS PROCESSING_TIME FROM (SELECT A.MACHINE_ID, A.PROCESS_ID, (A.TIMESTAMP - B.TIMESTAMP) AS PROCESS_TIME FROM ACTIVITY AS A JOIN ACTIVITY AS B ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID WHERE A.ACTIVITY_TYPE = 'end' AND B.ACTIVITY_TYPE = 'start' GROUP BY 1, 2) AS SUB GROUP BY 1;

/*
Prediction Result:
(0, -2.0)
(1, -2.333)
(2, 3.0)
(3, None)
*/