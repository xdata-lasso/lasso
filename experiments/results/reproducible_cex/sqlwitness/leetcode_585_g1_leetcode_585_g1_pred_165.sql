-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (1, 3, 3, NULL, NULL), (0, 1, NULL, 3, 2), (3, 3, NULL, 2, 1), (2, 0, 2, 2, 2), (4, 3, NULL, 3, 3), (5, NULL, 2, 3, 2), (6, 1, 0, NULL, 2), (7, 1, 0, 0, 2), (8, 2, 0, 1, 2), (9, 2, NULL, 0, NULL), (10, 0, 1, 1, 1), (11, 1, NULL, 3, 1), (12, 1, 3, 2, 0), (13, 2, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(6.0,)
*/

-- Prediction Query
SELECT SUM(I1.TIV_2016) AS TIV_2016 FROM INSURANCE AS I1 WHERE NOT (I1.LAT, I1.LON) IN (SELECT LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) > 1) AND I1.TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE GROUP BY TIV_2015 HAVING COUNT(*) > 1);

/*
Prediction Result:
(None,)
*/