-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (3, 1, 2, 1, 3), (1, 3, 3, 1, 3), (0, 2, 1, 2, 3), (2, 0, 3, NULL, 1), (4, 0, NULL, 3, 2), (5, 1, 1, 1, NULL), (6, 0, 2, NULL, NULL), (7, 2, 0, 2, 1), (8, 1, 3, 3, 0), (9, 2, 2, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(6.0,)
*/

-- Prediction Query
WITH UNIQUE_LOC AS (SELECT * FROM INSURANCE WHERE NOT (LAT, LON) IN (SELECT LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) > 1)), MULTIPLE_VALUE AS (SELECT * FROM INSURANCE WHERE TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE GROUP BY TIV_2015 HAVING COUNT(*) > 1)) SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM UNIQUE_LOC WHERE PID IN (SELECT PID FROM MULTIPLE_VALUE);

/*
Prediction Result:
(9.0,)
*/