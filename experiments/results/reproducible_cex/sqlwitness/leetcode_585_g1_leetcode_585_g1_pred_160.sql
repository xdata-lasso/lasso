-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (1, 0, 2, 2, NULL), (0, NULL, NULL, 1, 0), (2, 1, 3, 2, 1), (3, 3, 1, 0, 1), (4, 2, NULL, 1, 0), (5, 0, 3, 3, 3), (6, 1, NULL, NULL, 0), (7, NULL, NULL, 3, 2), (8, 1, 2, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(8.0,)
*/

-- Prediction Query
SELECT SUM(DISTINCT I.TIV_2016) AS TIV_2016 FROM INSURANCE AS I CROSS JOIN INSURANCE AS I1 WHERE I.PID <> I1.PID AND I.TIV_2015 = I1.TIV_2015 AND NOT I.PID IN (SELECT I.PID FROM INSURANCE AS I CROSS JOIN INSURANCE AS I1 WHERE I.PID <> I1.PID AND I.LAT = I1.LAT AND I.LON = I1.LON);

/*
Prediction Result:
(5.0,)
*/