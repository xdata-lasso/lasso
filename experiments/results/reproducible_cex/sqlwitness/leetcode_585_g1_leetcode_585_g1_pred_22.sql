-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (2, 2, 3, 2, NULL), (1, 2, 3, 3, 1), (0, 3, 1, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(3.0,)
*/

-- Prediction Query
SELECT SUM(I1.TIV_2016) AS TIV_2016 FROM INSURANCE AS I1 LEFT JOIN (SELECT PID, COUNT(*) OVER (PARTITION BY LAT || ' ' || LON) AS COUNT_LAT_LON, COUNT(*) OVER (PARTITION BY TIV_2015) AS COUNT_2015 FROM INSURANCE) AS I2 ON I1.PID = I2.PID WHERE I2.COUNT_LAT_LON = 1 AND I2.COUNT_2015 > 1;

/*
Prediction Result:
(6.0,)
*/