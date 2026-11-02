-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (2, 2, NULL, NULL, 2), (0, 1, 3, 1, 0), (3, 1, 3, 2, 1), (1, 0, 0, 0, 3), (4, 1, 3, 0, 0), (5, 3, 1, 1, 2), (6, 2, NULL, 2, 3), (7, 0, NULL, 2, 0), (8, 1, NULL, 1, 2), (9, NULL, 2, 2, 2), (10, 1, 2, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(9.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM INSURANCE WHERE PID IN (SELECT DISTINCT (A.PID) FROM INSURANCE AS A JOIN INSURANCE AS B ON A.PID <> B.PID WHERE (A.TIV_2015) = (B.TIV_2015) AND NOT A.PID IN (SELECT DISTINCT (A.PID) FROM INSURANCE AS A JOIN INSURANCE AS B ON A.PID <> B.PID WHERE (A.LAT, A.LON) = (B.LAT, B.LON)));

/*
Prediction Result:
(11.0,)
*/