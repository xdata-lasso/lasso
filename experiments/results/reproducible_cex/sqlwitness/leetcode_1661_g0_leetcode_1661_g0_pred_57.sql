-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (4, 4, 'start', 4), (4, 2, 'end', 4), (4, 2, 'start', 3), (2, 3, 'end', 4), (2, 2, 'end', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(4, 1.0)
*/

-- Prediction Query
SELECT A.MACHINE_ID, ROUND(AVG(A.TIMESTAMP - B.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS A JOIN ACTIVITY AS B ON A.MACHINE_ID = B.MACHINE_ID WHERE A.ACTIVITY_TYPE = 'end' AND B.ACTIVITY_TYPE = 'start' GROUP BY A.MACHINE_ID;

/*
Prediction Result:
(4, 0.5)
*/