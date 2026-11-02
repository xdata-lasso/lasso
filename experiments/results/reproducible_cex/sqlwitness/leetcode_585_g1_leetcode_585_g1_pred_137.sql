-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (3, NULL, NULL, 2, NULL), (1, 1, NULL, 1, 0), (0, NULL, 1, 0, 0), (2, 2, 3, NULL, 3), (4, 0, NULL, 3, 2), (5, 2, 1, 1, 1), (6, 1, 2, 0, 2), (7, NULL, 3, 1, 0), (8, 1, 1, 3, 1), (9, 3, 1, NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(4.0,)
*/

-- Prediction Query
SELECT SUM(TIV_2016) AS TIV_2016 FROM INSURANCE WHERE TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE GROUP BY 1 HAVING COUNT(TIV_2015) > 1) AND NOT LAT || LON IN (SELECT LAT || LON FROM INSURANCE GROUP BY 1 HAVING COUNT(*) > 1);

/*
Prediction Result:
(None,)
*/