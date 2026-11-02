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
SELECT A.MACHINE_ID, ROUND((CAST(A.SUM1 AS REAL) / B.CNT), 3) AS PROCESSING_TIME FROM (SELECT P.MACHINE_ID, SUM(P.TIMESTAMP1) AS SUM1 FROM (SELECT MACHINE_ID, PROCESS_ID, SUM(CASE WHEN ACTIVITY_TYPE = 'start' THEN -TIMESTAMP WHEN ACTIVITY_TYPE = 'end' THEN TIMESTAMP END) AS TIMESTAMP1 FROM ACTIVITY GROUP BY 1, 2) AS P GROUP BY 1) AS A INNER JOIN (SELECT MACHINE_ID, COUNT(DISTINCT PROCESS_ID) AS CNT FROM ACTIVITY GROUP BY 1) AS B ON A.MACHINE_ID = B.MACHINE_ID;

/*
Prediction Result:
(1, 8.333)
(2, -1.0)
(3, 10.0)
*/