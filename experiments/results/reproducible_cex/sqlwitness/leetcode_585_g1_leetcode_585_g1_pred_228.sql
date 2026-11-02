-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (2, 2, 0, 3, 2), (0, 2, NULL, 0, 0), (3, 1, 2, NULL, 0), (1, 1, 3, 3, 1), (4, 1, 3, 2, NULL), (5, 3, 3, 1, 3), (6, 1, 3, 1, 0), (7, 1, 0, 1, 1), (8, 0, 3, 3, 1), (9, 1, 0, 1, 0), (10, 3, 1, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(4.0,)
*/

-- Prediction Query
WITH TIV_COUNT AS (SELECT TIV_2015 FROM INSURANCE GROUP BY 1 HAVING COUNT(PID) > 1), LAT_LON_COUNT AS (SELECT LAT, LON FROM INSURANCE GROUP BY 1, 2 HAVING COUNT(PID) = 1) SELECT SUM(TIV_2016) AS TIV_2016 FROM INSURANCE WHERE TIV_2015 IN (SELECT TIV_2015 FROM TIV_COUNT) AND LAT IN (SELECT LAT FROM LAT_LON_COUNT) AND LON IN (SELECT LON FROM LAT_LON_COUNT);

/*
Prediction Result:
(10.0,)
*/