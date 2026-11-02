-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (0, 2, 2, NULL, 2), (3, 2, NULL, NULL, 3), (2, 2, 2, 1, NULL), (1, 1, NULL, 0, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(TIV_2016) AS TIV_2016 FROM INSURANCE AS I WHERE EXISTS(SELECT 1 FROM INSURANCE AS I2 WHERE I.PID <> I2.PID AND I.TIV_2015 = I2.TIV_2015) AND NOT EXISTS(SELECT 1 FROM INSURANCE AS I2 WHERE I.PID <> I2.PID AND I.LON = I2.LON AND I.LAT = I2.LAT);

/*
Prediction Result:
(4.0,)
*/