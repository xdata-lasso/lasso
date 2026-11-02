-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (1, 1, 0, NULL, 2), (0, 2, 0, NULL, 2), (3, 3, NULL, 2, 3), (2, 0, 2, 2, NULL), (4, NULL, 2, 2, 1), (5, 3, 2, 2, 3), (6, 0, 2, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(BASE.TIV_2016) AS TIV_2016 FROM (SELECT A.PID, A.TIV_2016 FROM (SELECT * FROM INSURANCE WHERE TIV_2015 IN (SELECT TIV_2015 FROM (SELECT TIV_2015, COUNT(*) AS N FROM INSURANCE GROUP BY TIV_2015) AS BASE15 WHERE N > 1)) AS A LEFT JOIN INSURANCE AS B ON A.PID <> B.PID AND A.LAT = B.LAT AND A.LON = B.LON WHERE B.PID IS NULL) AS BASE;

/*
Prediction Result:
(2.0,)
*/