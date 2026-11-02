-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (2, 1, 0, 1, 1), (3, 2, 3, 3, 0), (1, 2, 0, NULL, 3), (0, 3, 2, NULL, 1), (4, 3, 3, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(6.0,)
*/

-- Prediction Query
WITH T1 AS (SELECT DISTINCT A.PID FROM INSURANCE AS A JOIN INSURANCE AS B ON A.TIV_2015 = B.TIV_2015 AND (A.LAT, A.LON) <> (B.LAT, B.LON)), T2 AS (SELECT DISTINCT A.PID FROM INSURANCE AS A JOIN INSURANCE AS B ON A.PID <> B.PID AND (A.LAT, A.LON) = (B.LAT, B.LON)) SELECT SUM(TIV_2016) AS TIV_2016 FROM INSURANCE WHERE PID IN (SELECT PID FROM T1) AND NOT PID IN (SELECT PID FROM T2);

/*
Prediction Result:
(8.0,)
*/