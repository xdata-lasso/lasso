-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (2, 3, NULL, NULL, 3), (1, NULL, NULL, 2, 1), (0, 3, NULL, 3, 3), (3, 0, 1, 0, 2), (4, 1, 2, 1, 2), (5, 2, 3, 3, 0), (6, 0, NULL, NULL, 1), (7, 2, NULL, 0, 2), (8, NULL, 3, 1, 0), (9, 2, 2, 1, 3), (10, 1, NULL, 2, 2), (11, 2, 2, NULL, 3), (12, 0, 2, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(9.0,)
*/

-- Prediction Query
SELECT SUM(TIV_2016) AS TIV_2016 FROM (SELECT PID, TIV_2015, COUNT(PID) OVER (PARTITION BY TIV_2015) AS CT_2015, TIV_2016, COUNT(PID) OVER (PARTITION BY LAT || LON) AS CT_LOCATION FROM INSURANCE) AS SUB WHERE CT_2015 > 1 AND CT_LOCATION = 1;

/*
Prediction Result:
(12.0,)
*/