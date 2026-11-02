-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 5.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 15.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 10.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 3, 'end', 25.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 1, 'end', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1, 10.0)
*/

-- Prediction Query
SELECT S1.MACHINE_ID, ROUND(SUM(CAST(S2.PROCESS_TIME * 1.0 AS REAL) / S1.NO_OF_PROCESS), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, COUNT(DISTINCT (PROCESS_ID)) AS NO_OF_PROCESS FROM ACTIVITY GROUP BY MACHINE_ID) AS S1 INNER JOIN (SELECT A1.MACHINE_ID, A1.PROCESS_ID, A1.TIMESTAMP - A2.TIMESTAMP AS PROCESS_TIME FROM (SELECT * FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS A1 INNER JOIN (SELECT * FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID) AS S2 ON S1.MACHINE_ID = S2.MACHINE_ID GROUP BY S1.MACHINE_ID;

/*
Prediction Result:
(1, 3.333)
*/