-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 0.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 10.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'pause', 5.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 15.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 3, 'end', 25.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 50.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 1, 'end', 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 10.0)
*/

-- Prediction Query
WITH STARTTIME AS (SELECT MACHINE_ID, PROCESS_ID, ACTIVITY_TYPE, SUM(CASE WHEN ACTIVITY_TYPE = 'start' THEN TIMESTAMP ELSE 0 END) AS STARTTIME FROM ACTIVITY GROUP BY MACHINE_ID, PROCESS_ID), ENDTIME AS (SELECT MACHINE_ID, PROCESS_ID, ACTIVITY_TYPE, SUM(CASE WHEN ACTIVITY_TYPE = 'end' THEN TIMESTAMP ELSE 0 END) AS ENDTIME FROM ACTIVITY GROUP BY MACHINE_ID, PROCESS_ID), BASE AS (SELECT S.MACHINE_ID, S.PROCESS_ID, SUM(E.ENDTIME - S.STARTTIME) AS DIFF FROM STARTTIME AS S INNER JOIN ENDTIME AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID GROUP BY S.MACHINE_ID, S.PROCESS_ID) SELECT MACHINE_ID, AVG(AV) AS PROCESSING_TIME FROM (SELECT *, ROUND(AVG(DIFF) OVER (PARTITION BY MACHINE_ID), 3) AS AV FROM BASE) AS T GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, 6.666999999999999)
(2, -50.0)
(3, 60.0)
*/