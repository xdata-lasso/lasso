-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 1.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 4.500);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'pause', 2.500);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 2.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 3, 'end', 9.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', 10.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'end', 15.250);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'start', 20.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'START', 21.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'END', 25.000);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 1, 'start', 5.000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(1, 3.5)
(2, 5.25)
*/

-- Prediction Query
WITH END_TBL AS (SELECT A.MACHINE_ID, A.PROCESS_ID, A.ACTIVITY_TYPE, A.TIMESTAMP AS END_TIME FROM ACTIVITY AS A WHERE A.ACTIVITY_TYPE = 'end'), START_TBL AS (SELECT A.MACHINE_ID, A.PROCESS_ID, A.ACTIVITY_TYPE, A.TIMESTAMP AS START_TIME FROM ACTIVITY AS A WHERE A.ACTIVITY_TYPE = 'start'), TIMEDIFF_TBL AS (SELECT END_TBL.MACHINE_ID, END_TBL.PROCESS_ID, (END_TBL.END_TIME - START_TBL.START_TIME) AS TIMEDIFF FROM END_TBL LEFT JOIN START_TBL ON START_TBL.MACHINE_ID = END_TBL.MACHINE_ID AND START_TBL.PROCESS_ID = END_TBL.PROCESS_ID), RUN_COUNT_TBL AS (SELECT TD.MACHINE_ID, COUNT(*) AS RUN_COUNT FROM TIMEDIFF_TBL AS TD GROUP BY TD.MACHINE_ID), FINAL_TBL AS (SELECT TD.MACHINE_ID, ROUND(SUM(TD.TIMEDIFF), 3) AS TOTAL_RUN_TIME, RUN_COUNT_TBL.RUN_COUNT FROM TIMEDIFF_TBL AS TD LEFT JOIN RUN_COUNT_TBL ON RUN_COUNT_TBL.MACHINE_ID = TD.MACHINE_ID GROUP BY TD.MACHINE_ID) SELECT FINAL_TBL.MACHINE_ID, ROUND(CAST(FINAL_TBL.TOTAL_RUN_TIME AS REAL) / FINAL_TBL.RUN_COUNT, 3) AS PROCESSING_TIME FROM FINAL_TBL;

/*
Prediction Result:
(1, 1.75)
(2, 5.25)
*/