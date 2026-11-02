-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 2), (2, 3, 'end', 1), (0, 0, 'start', 1), (3, 4, 'start', 4), (3, 0, 'end', NULL), (2, 0, 'start', NULL), (4, 4, 'end', NULL), (3, 2, 'end', 4), (3, 4, 'end', NULL), (3, 3, 'start', 3), (0, 0, 'end', NULL), (3, 1, 'start', 1), (2, 2, 'end', 1), (1, 2, 'end', 0), (3, 1, 'end', 2), (3, 3, 'end', 2), (2, 3, 'start', NULL), (1, 1, 'start', 1), (3, 0, 'start', 3), (2, 1, 'end', 0), (0, 1, 'end', 4), (4, 0, 'start', 0), (4, 4, 'start', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(0, None)
(2, None)
(3, 0.4)
(4, None)
*/

-- Prediction Query
SELECT A.MACHINE_ID, ROUND(AVG(B.TIMESTAMP - A.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS A JOIN ACTIVITY AS B ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID WHERE B.ACTIVITY_TYPE = 'end' AND A.ACTIVITY_TYPE = 'start' GROUP BY A.MACHINE_ID ORDER BY A.MACHINE_ID, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(0, None)
(2, None)
(3, 0.667)
(4, None)
*/