-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (2, NULL, 0, 3, 2), (1, 3, 1, 2, 2), (3, NULL, 2, NULL, 3), (0, NULL, 3, NULL, 0), (4, 3, NULL, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH T1 AS (SELECT PID FROM INSURANCE GROUP BY TIV_2015 HAVING COUNT(*) = 1), T2 AS (SELECT PID FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) = 1) SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM INSURANCE WHERE NOT PID IN (SELECT * FROM T1) AND PID IN (SELECT * FROM T2);

/*
Prediction Result:
(5.0,)
*/