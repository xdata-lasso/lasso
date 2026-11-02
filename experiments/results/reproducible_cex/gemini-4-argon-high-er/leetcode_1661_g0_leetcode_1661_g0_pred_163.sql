-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 1, 'start', 1.0);
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES (1, 2, 'end', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT MACHINE_ID, TIMESTAMP AS START FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start'), CTE2 AS (SELECT MACHINE_ID, TIMESTAMP AS END FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') SELECT CTE.MACHINE_ID, ROUND(AVG(END - START), 3) AS PROCESSING_TIME FROM CTE JOIN CTE2 ON CTE.MACHINE_ID = CTE2.MACHINE_ID GROUP BY 1;

/*
Prediction Result:
(1, 1.0)
*/