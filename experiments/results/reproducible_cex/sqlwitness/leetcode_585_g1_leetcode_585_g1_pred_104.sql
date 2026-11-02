-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (1, 2, 2, 2, 0), (0, 1, 0, 2, 0), (3, 3, 2, NULL, 1), (2, 2, 0, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM (SELECT DISTINCT I1.* FROM INSURANCE AS I1 JOIN INSURANCE AS I2 ON I1.TIV_2015 = I2.TIV_2015 AND I1.PID <> I2.PID AND (I1.LAT <> I2.LAT OR I1.LON <> I2.LON) AND NOT (I1.LAT, I1.LON) IN (SELECT DISTINCT LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) > 1)) AS A;

/*
Prediction Result:
(0.0,)
*/