-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'start', 1), (3, 0, 'start', 0), (3, 3, 'start', 4), (3, 0, 'end', 4), (3, 1, 'start', NULL), (2, 1, 'start', NULL), (0, 4, 'start', 2), (1, 0, 'start', 0), (3, 3, 'end', 4), (0, 3, 'end', NULL), (0, 4, 'end', 3), (2, 4, 'end', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(0, 1.0)
(3, 2.0)
*/

-- Prediction Query
WITH CTE AS (SELECT A.MACHINE_ID, A.PROCESS_ID, (B.TIMESTAMP - A.TIMESTAMP) AS PROCESSING_TIME FROM ACTIVITY AS A INNER JOIN ACTIVITY AS B ON A.MACHINE_ID = B.MACHINE_ID AND A.PROCESS_ID = B.PROCESS_ID AND A.TIMESTAMP < B.TIMESTAMP) SELECT MACHINE_ID, ROUND(AVG(PROCESSING_TIME), 3) AS PROCESSING_TIME FROM CTE GROUP BY MACHINE_ID;

/*
Prediction Result:
(0, 1.0)
(3, 4.0)
*/