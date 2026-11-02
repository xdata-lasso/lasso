-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 4, 'end', 2), (0, 2, 'end', 0), (2, 0, 'start', 0), (4, 4, 'end', 1), (3, 3, 'start', 1), (3, 0, 'start', 3), (3, 2, 'end', 2), (0, 1, 'start', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.MACHINE_ID, ROUND(CAST(SUM(A2.TIMESTAMP - A1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end' GROUP BY A1.MACHINE_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT MACHINE_ID, TIMESTAMP AS START FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start'), CTE2 AS (SELECT MACHINE_ID, TIMESTAMP AS END FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') SELECT CTE.MACHINE_ID, ROUND(AVG(END - START), 3) AS PROCESSING_TIME FROM CTE JOIN CTE2 ON CTE.MACHINE_ID = CTE2.MACHINE_ID GROUP BY 1;

/*
Prediction Result:
(0, -1.0)
(3, 0.0)
*/