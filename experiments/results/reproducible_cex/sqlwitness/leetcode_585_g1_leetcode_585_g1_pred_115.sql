-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (3, NULL, 0, 2, 1), (2, 1, NULL, 3, 1), (1, 0, 1, 1, 0), (0, 0, 1, 1, 3), (4, 2, 3, NULL, 3), (5, 1, 1, 2, 1), (6, 3, 1, 0, NULL), (7, 0, 1, NULL, 0), (8, 0, NULL, 2, 1), (9, 2, 2, NULL, 0), (10, 3, 3, 2, 0), (11, 2, 1, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(5.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(DISTINCT A.TIV_2016), 2) AS TIV_2016 FROM INSURANCE AS A JOIN INSURANCE AS B ON A.TIV_2015 = B.TIV_2015 WHERE A.PID <> B.PID AND A.PID IN (SELECT DISTINCT I.PID FROM INSURANCE AS I JOIN INSURANCE AS J ON I.LAT = J.LAT AND I.LON = J.LON GROUP BY I.PID HAVING COUNT(DISTINCT J.PID) = 1);

/*
Prediction Result:
(4.0,)
*/