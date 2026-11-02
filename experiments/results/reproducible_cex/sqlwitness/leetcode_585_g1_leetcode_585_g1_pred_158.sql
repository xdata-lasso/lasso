-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (3, 3, 2, 0, NULL), (2, 3, 0, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT SUM(C.TIV_2016) AS TIV_2016 FROM (SELECT A.PID, A.TIV_2015, A.TIV_2016, A.LAT, A.LON FROM INSURANCE AS A INNER JOIN INSURANCE AS B ON A.TIV_2015 = B.TIV_2015 AND A.PID <> B.PID GROUP BY A.PID, A.TIV_2015, A.TIV_2016, A.LAT, A.LON) AS C LEFT JOIN INSURANCE AS D ON (C.LAT = D.LAT) AND (C.LON = D.LON) AND C.PID <> D.PID WHERE D.PID IS NULL;

/*
Prediction Result:
(2.0,)
*/