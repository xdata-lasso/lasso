-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 0.0004);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 0.0008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1, 0.0)
*/

-- Prediction Query
SELECT TMP.MACHINE_ID AS MACHINE_ID, ROUND(CAST(SUM(TMP.TIME_DIFF) AS REAL) / COUNT(TMP.TIME_DIFF), 3) AS PROCESSING_TIME FROM (SELECT A.MACHINE_ID, ROUND(SUM(CASE WHEN A.ACTIVITY_TYPE = 'end' THEN A.TIMESTAMP ELSE 0 END), 3) - ROUND(SUM(CASE WHEN A.ACTIVITY_TYPE = 'start' THEN A.TIMESTAMP ELSE 0 END), 3) AS TIME_DIFF FROM ACTIVITY AS A GROUP BY A.MACHINE_ID, A.PROCESS_ID) AS TMP GROUP BY TMP.MACHINE_ID;

/*
Prediction Result:
(1, 0.001)
*/