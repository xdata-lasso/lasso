-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (1, 0, 0, 1, 3), (0, 2, 0, NULL, 1), (3, NULL, 1, 0, 1), (2, 0, 1, 1, 0), (4, 2, 3, NULL, 0), (5, NULL, 2, 2, 3), (6, NULL, NULL, 1, 1), (7, 3, 2, NULL, NULL), (8, 1, 2, 0, 3), (9, 1, NULL, NULL, 1), (10, 1, 1, 1, NULL), (11, 1, 1, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(3.0,)
*/

-- Prediction Query
SELECT SUM(TIV_2016) AS TIV_2016 FROM INSURANCE WHERE PID IN (SELECT DISTINCT PID FROM (SELECT PID, COUNT(*) OVER (PARTITION BY TIV_2015) AS NUM15, COUNT(*) OVER (PARTITION BY LAT || LON) AS NUM_LOC FROM INSURANCE) AS X WHERE NUM15 > 1 AND NUM_LOC = 1);

/*
Prediction Result:
(6.0,)
*/