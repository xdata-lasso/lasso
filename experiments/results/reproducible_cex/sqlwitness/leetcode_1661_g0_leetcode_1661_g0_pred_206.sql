-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', NULL), (2, 3, 'end', 4), (0, 0, 'start', NULL), (3, 0, 'end', 2), (4, 0, 'end', 2), (1, 0, 'start', NULL), (4, 2, 'end', 1), (3, 2, 'end', 4), (3, 4, 'end', 3), (3, 3, 'start', 4), (3, 1, 'start', 3), (0, 4, 'end', 2), (4, 3, 'start', 4), (0, 1, 'start', NULL), (1, 2, 'end', 3), (3, 1, 'end', 1), (3, 3, 'end', 3), (1, 1, 'start', 2), (0, 1, 'end', 1), (4, 2, 'start', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(0, None)
(3, -1.5)
(4, -2.0)
*/

-- Prediction Query
SELECT A.MACHINE_ID, ROUND(CAST(SUM(B.TIMESTAMP - A.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A JOIN ACTIVITY AS B ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID AND A.ACTIVITY_TYPE <> B.ACTIVITY_TYPE WHERE A.ACTIVITY_TYPE = 'start' GROUP BY A.MACHINE_ID;

/*
Prediction Result:
(0, None)
(3, -1.0)
(4, -2.0)
*/