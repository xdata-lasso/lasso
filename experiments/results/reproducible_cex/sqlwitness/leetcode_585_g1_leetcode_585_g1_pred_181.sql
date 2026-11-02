-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (1, 0, NULL, 1, 3), (0, NULL, 3, 1, 2), (3, 3, 1, 0, 0), (2, NULL, 2, 1, 0), (4, NULL, 1, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(TIV_2016) AS TIV_2016 FROM (SELECT *, COUNT(PID) OVER (PARTITION BY TIV_2015) AS NUM_2015 FROM INSURANCE) AS TEMP WHERE NUM_2015 >= 2 AND NOT PID IN (SELECT I1.PID FROM INSURANCE AS I1 INNER JOIN (SELECT PID, LAT, LON FROM INSURANCE) AS I2 ON I1.PID <> I2.PID WHERE I1.LAT = I2.LAT AND I1.LON = I2.LON);

/*
Prediction Result:
(6.0,)
*/