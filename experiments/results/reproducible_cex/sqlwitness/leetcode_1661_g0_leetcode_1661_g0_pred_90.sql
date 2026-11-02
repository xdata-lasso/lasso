-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 0, 'start', 4), (1, 1, 'start', 3), (3, 4, 'end', 1), (4, 3, 'start', 2), (1, 1, 'end', 3), (3, 0, 'end', 1), (3, 1, 'start', 1), (4, 0, 'start', 0), (4, 0, 'end', 2), (3, 3, 'end', 2), (1, 0, 'end', 4), (2, 4, 'start', NULL), (2, 0, 'start', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1, 0.0)
(4, 2.0)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(DUR), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, (TIMESTAMP - LEAD(TIMESTAMP, 1) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY ACTIVITY_TYPE DESC)) AS DUR FROM ACTIVITY) AS T WHERE NOT DUR IS NULL GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, 0.0)
(4, -2.0)
*/