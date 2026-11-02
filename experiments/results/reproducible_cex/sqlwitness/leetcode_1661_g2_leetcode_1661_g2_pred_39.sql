-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 3), (2, 3, 'end', 0), (3, 4, 'start', NULL), (1, 1, 'end', 2), (3, 0, 'end', 4), (4, 4, 'end', 0), (2, 2, 'start', 4), (3, 2, 'end', 1), (3, 4, 'end', 0), (3, 3, 'start', 0), (3, 1, 'start', 2), (0, 2, 'end', 1), (1, 0, 'end', 2), (0, 4, 'end', 1), (2, 0, 'end', 2), (2, 2, 'end', NULL), (0, 1, 'start', 1), (3, 1, 'end', 4), (3, 3, 'end', 1), (1, 3, 'start', 1), (2, 3, 'start', 4), (3, 0, 'start', 4), (0, 1, 'end', NULL), (0, 3, 'end', 0), (1, 3, 'end', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(0, None)
(1, 3.0)
(2, -2.0)
(3, 0.2)
*/

-- Prediction Query
SELECT TEMP.MACHINE_ID, ROUND(AVG(END - BEGIN), 3) AS PROCESSING_TIME FROM (SELECT A.MACHINE_ID, A.TIMESTAMP AS BEGIN, B.TIMESTAMP AS END FROM ACTIVITY AS A CROSS JOIN ACTIVITY AS B WHERE A.ACTIVITY_TYPE = 'start' AND B.ACTIVITY_TYPE = 'end' AND A.PROCESS_ID = B.PROCESS_ID AND A.MACHINE_ID = B.MACHINE_ID) AS TEMP GROUP BY TEMP.MACHINE_ID;

/*
Prediction Result:
(0, None)
(1, 3.0)
(2, -4.0)
(3, 0.25)
*/