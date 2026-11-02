-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (0, 1, 0, 1, NULL), (1, 1, 3, 1, 0), (2, 1, 2, 0, NULL), (3, NULL, 3, 2, 1), (4, 3, 1, 2, 3), (5, 3, 0, 0, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(4.0,)
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT A.PID, A.LAT, A.LON FROM INSURANCE AS A JOIN INSURANCE AS B ON A.PID <> B.PID AND A.TIV_2015 = B.TIV_2015), TMP AS (SELECT PID FROM CTE WHERE NOT LAT || LON IN (SELECT LAT || LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) > 1)) SELECT SUM(TIV_2016) AS TIV_2016 FROM INSURANCE WHERE PID IN (SELECT PID FROM TMP);

/*
Prediction Result:
(6.0,)
*/