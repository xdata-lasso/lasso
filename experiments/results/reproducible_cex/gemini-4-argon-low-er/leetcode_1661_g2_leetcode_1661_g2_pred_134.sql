-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 0.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'end', 1.12345);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
(1, 1.123)
*/

-- Prediction Query
WITH T AS (SELECT MACHINE_ID, PROCESS_ID, ACTIVITY_TYPE, TIMESTAMP AS STS, LEAD(TIMESTAMP) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY TIMESTAMP) AS ETS FROM ACTIVITY) SELECT MACHINE_ID, CAST(AVG(ETS - STS) AS REAL(26, 3)) AS PROCESSING_TIME FROM T WHERE ACTIVITY_TYPE = 'start' GROUP BY 1;

/*
Prediction Result:
(1, 1.12345)
*/