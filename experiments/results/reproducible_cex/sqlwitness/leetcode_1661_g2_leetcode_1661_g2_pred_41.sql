-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 4), (3, 4, 'start', 2), (3, 0, 'end', 4), (0, 4, 'start', 3), (4, 0, 'end', 4), (4, 4, 'end', 0), (3, 2, 'end', 2), (3, 4, 'end', 4), (1, 2, 'start', 0), (3, 3, 'start', 4), (0, 2, 'end', 4), (2, 4, 'start', 1), (4, 3, 'start', NULL), (2, 0, 'end', 4), (2, 2, 'end', NULL), (1, 2, 'end', 3), (2, 1, 'start', 0), (3, 1, 'end', 0), (3, 3, 'end', 4), (4, 1, 'end', NULL), (1, 3, 'start', 2), (2, 4, 'end', 1), (2, 3, 'start', 2), (4, 0, 'start', 3), (1, 3, 'end', NULL), (4, 4, 'start', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 1.5)
(2, 0.0)
(3, 0.0)
(4, -1.5)
*/

-- Prediction Query
WITH CTE AS (SELECT A.MACHINE_ID, A.TIMESTAMP - B.TIMESTAMP AS PROCESSING_TIME FROM ACTIVITY AS A LEFT JOIN ACTIVITY AS B ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID WHERE A.ACTIVITY_TYPE <> B.ACTIVITY_TYPE AND A.ACTIVITY_TYPE = 'end') SELECT CTE.MACHINE_ID, ROUND(AVG(CTE.PROCESSING_TIME), 3) AS PROCESSING_TIME FROM CTE GROUP BY CTE.MACHINE_ID ORDER BY CTE.MACHINE_ID ASC, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(1, 3.0)
(2, 0.0)
(3, 0.0)
(4, -1.5)
*/