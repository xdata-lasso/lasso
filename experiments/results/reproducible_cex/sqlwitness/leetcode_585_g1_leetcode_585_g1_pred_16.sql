-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (3, 3, NULL, 2, 1), (0, NULL, 3, NULL, 1), (2, NULL, 1, 1, 1), (1, 2, 1, 3, 0), (4, 3, 2, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM INSURANCE AS I1 WHERE EXISTS(SELECT * FROM INSURANCE AS I2 WHERE I1.PID <> I2.PID AND I1.TIV_2015 = I2.TIV_2015) AND NOT EXISTS(SELECT * FROM INSURANCE AS I3 WHERE I1.PID <> I3.PID AND I1.LAT = I3.LAT AND I1.LON = I3.LON);

/*
Prediction Result:
(2.0,)
*/