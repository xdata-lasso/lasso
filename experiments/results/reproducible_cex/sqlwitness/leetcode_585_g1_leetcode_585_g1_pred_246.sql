-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (0, 0, 2, 3, 2), (2, 1, 0, NULL, 3), (1, 1, 2, 1, NULL), (3, 3, 2, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH T AS (SELECT DISTINCT A.* FROM INSURANCE AS A LEFT JOIN INSURANCE AS B ON A.TIV_2015 = B.TIV_2015 AND A.PID <> B.PID WHERE NOT B.PID IS NULL) SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM T WHERE NOT (LAT, LON) IN (SELECT LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(DISTINCT PID) > 1);

/*
Prediction Result:
(2.0,)
*/