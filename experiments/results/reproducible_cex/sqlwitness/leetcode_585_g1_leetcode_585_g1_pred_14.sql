-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (2, 3, 2, 1, NULL), (1, 2, 3, 0, 0), (0, 2, 2, 2, NULL), (3, 3, 0, 3, 0), (4, NULL, NULL, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(3.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM INSURANCE AS A WHERE EXISTS(SELECT TIV_2016 FROM INSURANCE WHERE PID <> A.PID AND TIV_2015 = A.TIV_2015) AND NOT EXISTS(SELECT TIV_2016 FROM INSURANCE WHERE PID <> A.PID AND (LAT, LON) = (A.LAT, A.LON));

/*
Prediction Result:
(7.0,)
*/