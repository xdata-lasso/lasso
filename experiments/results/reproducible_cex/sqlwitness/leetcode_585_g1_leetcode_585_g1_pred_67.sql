-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (1, 1, 0, 3, 3), (0, 3, NULL, 1, 1), (2, 0, 3, NULL, 3), (3, 1, 1, NULL, 1), (4, 1, 1, 1, 2), (5, 0, 2, 2, 2), (6, 0, 1, 1, 2), (7, 0, 2, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
WITH "2015VAL" AS (SELECT TIV_2015 FROM INSURANCE GROUP BY 1 HAVING COUNT(TIV_2015) > 1), DIFFCITY AS (SELECT LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(1) > 1) SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM INSURANCE WHERE TIV_2015 IN (SELECT * FROM "2015VAL") AND NOT (LAT, LON) IN (SELECT * FROM DIFFCITY);

/*
Prediction Result:
(6.0,)
*/