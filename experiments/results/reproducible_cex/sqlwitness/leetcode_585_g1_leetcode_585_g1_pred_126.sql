-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (0, NULL, 2, 2, 0), (1, 1, 3, 0, 0), (2, 2, 0, NULL, NULL), (3, 1, 2, 1, 2), (4, NULL, 1, 2, NULL), (5, NULL, NULL, 2, 3), (6, 1, NULL, 2, NULL), (7, 3, 2, 1, 0), (8, 0, 0, 1, 3), (9, 0, 1, 0, 0), (10, 0, 2, 0, 3), (11, NULL, 1, 2, 2), (12, NULL, 1, NULL, NULL), (13, 0, 0, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(4.0,)
*/

-- Prediction Query
SELECT SUM(A.TIV_2016) AS TIV_2016 FROM (SELECT A.TIV_2016, A.LAT, A.LON, COUNT(*) OVER (PARTITION BY A.TIV_2015) AS ROW_NUMBER FROM INSURANCE AS A) AS A INNER JOIN (SELECT LAT, LON, COUNT(*) FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) = 1) AS B ON A.LAT = B.LAT AND A.LON = B.LON WHERE A.ROW_NUMBER > 1;

/*
Prediction Result:
(7.0,)
*/