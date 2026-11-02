-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (3, 1, 3, 1, 3), (2, 0, 1, 3, 1), (0, 1, NULL, NULL, 2), (1, 2, NULL, 3, 1), (4, 2, NULL, 1, 1), (5, 3, NULL, 1, 0), (6, 3, NULL, 3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(3.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(I1.TIV_2016), 2) AS TIV_2016 FROM INSURANCE AS I1 WHERE I1.TIV_2015 IN (SELECT I2.TIV_2015 FROM INSURANCE AS I2 WHERE I1.PID <> I2.PID) AND NOT I1.LAT || I1.LON IN (SELECT I3.LAT || I3.LON FROM INSURANCE AS I3 WHERE I1.PID <> I3.PID);

/*
Prediction Result:
(None,)
*/