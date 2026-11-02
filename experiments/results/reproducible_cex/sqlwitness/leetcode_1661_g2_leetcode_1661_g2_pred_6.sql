-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'start', 4), (3, 4, 'start', 0), (3, 4, 'end', 0), (1, 1, 'end', 3), (1, 1, 'start', 4), (2, 1, 'end', 2), (0, 3, 'start', 1), (1, 0, 'start', NULL), (0, 2, 'end', NULL), (1, 0, 'end', 3), (4, 2, 'start', 0), (4, 2, 'end', 0), (2, 0, 'start', 2), (4, 3, 'end', 3), (2, 2, 'start', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, -0.5)
(3, 0.0)
(4, 0.0)
*/

-- Prediction Query
SELECT A.MACHINE_ID, ROUND(AVG(B.TIMESTAMP - A.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS A LEFT JOIN ACTIVITY AS B ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID WHERE A.ACTIVITY_TYPE = 'start' AND B.ACTIVITY_TYPE = 'end' GROUP BY 1;

/*
Prediction Result:
(1, -1.0)
(3, 0.0)
(4, 0.0)
*/