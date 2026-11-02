-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (1, 0, 0, 1, 1), (0, 2, 0, NULL, 1), (2, 0, 1, 1, NULL), (3, 1, NULL, 3, 0), (4, 0, 2, 1, 3), (5, 0, NULL, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
WITH NOT_SAME_LOC AS (SELECT PID FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) = 1), INVESTMENT AS (SELECT PID FROM INSURANCE GROUP BY TIV_2015 HAVING COUNT(*) = 1) SELECT SUM(TIV_2016) AS TIV_2016 FROM INSURANCE WHERE PID IN (SELECT PID FROM NOT_SAME_LOC) AND NOT PID IN (SELECT PID FROM INVESTMENT);

/*
Prediction Result:
(3.0,)
*/