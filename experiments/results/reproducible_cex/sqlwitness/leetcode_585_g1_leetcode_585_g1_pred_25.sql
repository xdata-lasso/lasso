-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (0, 0, 3, 0, 0), (1, 2, 1, 3, 2), (2, 2, 3, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT SUM(TIV_2016) AS TIV_2016 FROM (SELECT PID, TIV_2015, TIV_2016, COUNT(*) OVER (PARTITION BY TIV_2015) AS CNT, COUNT(*) OVER (PARTITION BY LAT || ',' || LON) AS LOC_CNT FROM INSURANCE) AS T WHERE CNT > 1 AND LOC_CNT = 1;

/*
Prediction Result:
(4.0,)
*/