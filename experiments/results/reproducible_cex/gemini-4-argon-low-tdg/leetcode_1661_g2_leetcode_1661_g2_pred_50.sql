-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 11.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 2.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'end', NULL);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'start', NULL);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 1, 'end', 15.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'start', 5.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 2, 'end', 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 5.0)
(2, 10.0)
*/

-- Prediction Query
WITH START_TIME AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start' GROUP BY MACHINE_ID, PROCESS_ID ORDER BY MACHINE_ID, PROCESS_ID NULLS LAST, TIMESTAMP NULLS LAST), END_TIME AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end' GROUP BY MACHINE_ID, PROCESS_ID ORDER BY MACHINE_ID, PROCESS_ID NULLS LAST, TIMESTAMP NULLS LAST), DURATION AS (SELECT S.MACHINE_ID, ROUND(E.TIMESTAMP - S.TIMESTAMP, 3) AS DURATIONS FROM START_TIME AS S JOIN END_TIME AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID) SELECT MACHINE_ID, ROUND(AVG(DURATIONS), 3) AS PROCESSING_TIME FROM DURATION GROUP BY MACHINE_ID ORDER BY MACHINE_ID, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(1, 10.0)
(2, 20.0)
*/