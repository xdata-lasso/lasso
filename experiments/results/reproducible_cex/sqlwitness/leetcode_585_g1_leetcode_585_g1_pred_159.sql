-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (0, 1, NULL, 1, 0), (3, 1, 2, 1, 3), (2, NULL, 1, 3, 3), (1, 0, NULL, NULL, 0), (4, 0, 2, 2, 0), (5, 0, 2, 1, 0), (6, 1, NULL, 3, 3), (7, 2, 0, 3, 3), (8, 3, 2, 1, 3), (9, NULL, 2, 1, 2), (10, NULL, 0, NULL, 2), (11, 1, 0, 1, 1), (12, 2, NULL, 2, NULL), (13, 0, 1, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
SELECT SUM(DISTINCT A.TIV_2016) AS TIV_2016 FROM (SELECT * FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) = 1) AS A CROSS JOIN INSURANCE AS B WHERE A.PID <> B.PID AND A.TIV_2015 = B.TIV_2015;

/*
Prediction Result:
(3.0,)
*/