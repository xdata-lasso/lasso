-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 3.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'end', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 1.0)
*/

-- Prediction Query
WITH E AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS END_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end'), S AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS START_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') SELECT E.MACHINE_ID, ROUND(AVG(E.END_TIME - S.START_TIME), 3) AS PROCESSING_TIME FROM E JOIN S ON E.MACHINE_ID = S.MACHINE_ID AND E.PROCESS_ID = S.PROCESS_ID GROUP BY E.MACHINE_ID;

/*
Prediction Result:
(1, 2.0)
*/