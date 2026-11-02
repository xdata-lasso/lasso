-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (3, 1, 1, 1, 3), (0, 1, 0, 1, NULL), (1, 2, 0, 2, 1), (2, 1, 2, 1, 0), (4, 2, 0, 1, NULL), (5, 1, 2, 0, NULL), (6, 3, 2, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(3.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(SUB.TIV_2016), 2) AS TIV_2016 FROM (SELECT DISTINCT A.PID, A.TIV_2016 FROM INSURANCE AS A JOIN INSURANCE AS B ON A.TIV_2015 = B.TIV_2015 AND A.PID <> B.PID WHERE A.PID IN (SELECT PID FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(PID) = 1)) AS SUB;

/*
Prediction Result:
(5.0,)
*/