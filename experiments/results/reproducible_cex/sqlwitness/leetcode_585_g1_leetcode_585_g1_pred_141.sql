-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (1, 2, 0, 0, 3), (0, 3, NULL, 1, 1), (2, 1, NULL, 1, 1), (3, 0, NULL, NULL, NULL), (4, 1, 3, NULL, 3), (5, NULL, NULL, 0, NULL), (6, NULL, 1, 3, 1), (7, NULL, 1, 1, 3), (8, 3, 2, 2, 1), (9, 3, 0, NULL, 2), (10, 1, 0, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
SELECT SUM(TIV_2016) AS TIV_2016 FROM (SELECT *, COUNT(*) OVER (PARTITION BY TIV_2015) AS NUM_2015, COUNT(*) OVER (PARTITION BY LAT || LON) AS NUM_LOC FROM INSURANCE) AS X WHERE NUM_2015 > 1 AND NUM_LOC = 1;

/*
Prediction Result:
(4.0,)
*/