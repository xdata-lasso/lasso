-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (1, 0, 1, 1, 2), (2, 1, NULL, 0, 2), (3, 0, 3, 3, 0), (0, NULL, NULL, 0, NULL), (4, 0, 2, 2, 0), (5, 0, 3, NULL, 0), (6, 1, 0, 0, 0), (7, 1, 1, 0, 2), (8, 2, 2, NULL, 0), (9, 1, NULL, 3, 0), (10, 1, 2, 3, 1), (11, 3, 1, 0, 3), (12, 0, NULL, NULL, 2), (13, NULL, 3, 1, 0), (14, 1, NULL, 0, 2), (15, NULL, NULL, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(5.0,)
*/

-- Prediction Query
SELECT SUM(TIV_2016) AS TIV_2016 FROM INSURANCE AS I JOIN (SELECT PID FROM INSURANCE WHERE LAT || LON IN (SELECT LAT || LON FROM INSURANCE GROUP BY LAT || LON HAVING COUNT(*) = 1)) AS P ON I.PID = P.PID JOIN (SELECT PID FROM INSURANCE WHERE TIV_2015 IN ((SELECT TIV_2015 FROM INSURANCE GROUP BY 1 HAVING COUNT(*) > 1))) AS Q ON I.PID = Q.PID;

/*
Prediction Result:
(None,)
*/