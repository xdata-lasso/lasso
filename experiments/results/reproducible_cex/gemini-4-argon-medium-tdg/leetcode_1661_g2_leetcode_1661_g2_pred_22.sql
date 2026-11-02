-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 0, 'start', 10.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 0, 'end', 11.1239);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 20.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 22.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 30.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'end', 34.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 0, 'start', 5.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 0, 'end', 10.500);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 15.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'end', 20.500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 2.375)
(2, 5.5)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(AVG(T), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, LAST_VALUE(TIMESTAMP) OVER W - FIRST_VALUE(TIMESTAMP) OVER W AS T FROM ACTIVITY WINDOW W AS (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY ACTIVITY_TYPE)) AS B GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, -1.187)
(2, -2.75)
*/