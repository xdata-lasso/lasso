-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (1, 2, 2, 0, 1), (0, 3, 1, NULL, 2), (3, 3, NULL, 0, 3), (2, 3, NULL, 1, 3), (4, 2, NULL, 0, NULL), (5, 1, 3, NULL, 3), (6, 3, NULL, 2, NULL), (7, 0, 2, NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(A.TIV_2016), 2) AS TIV_2016 FROM INSURANCE AS A WHERE 1 > (SELECT COUNT(B.PID) FROM INSURANCE AS B WHERE (A.PID <> B.PID AND (B.LAT, B.LON) = (A.LAT, A.LON))) AND 1 <= (SELECT COUNT(C.PID) FROM INSURANCE AS C WHERE (A.PID <> C.PID AND A.TIV_2015 = C.TIV_2015));

/*
Prediction Result:
(3.0,)
*/