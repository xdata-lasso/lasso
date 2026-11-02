-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (0, 1, 1, 2, 2), (2, 2, 3, 0, 2), (1, 3, NULL, NULL, NULL), (3, 1, 0, NULL, NULL), (4, 0, 1, 2, NULL), (5, 0, NULL, 2, NULL), (6, 1, 1, 0, 3), (7, 2, NULL, 3, 1), (8, NULL, 1, 1, 0), (9, 1, 1, 3, 2), (10, NULL, 0, 1, 3), (11, 0, 2, 2, 2), (12, 2, 2, NULL, 1), (13, 1, 1, 2, 3), (14, 0, NULL, 2, 2), (15, 0, 0, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(6.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM (SELECT DISTINCT I1.PID, I1.TIV_2016 FROM INSURANCE AS I1 CROSS JOIN INSURANCE AS I2 WHERE I1.PID <> I2.PID AND I1.TIV_2015 = I2.TIV_2015) AS T1 JOIN (SELECT PID, LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) = 1) AS T2 ON T1.PID = T2.PID;

/*
Prediction Result:
(8.0,)
*/