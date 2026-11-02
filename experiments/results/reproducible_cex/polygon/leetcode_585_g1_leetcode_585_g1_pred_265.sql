-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (20, 0, 1, NULL, 15);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (12, 0, NULL, NULL, 17);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH T AS (SELECT PID, TIV_2016, LAT, LON FROM INSURANCE GROUP BY 3, 4 HAVING COUNT(*) = 1) SELECT ROUND(SUM(I.TIV_2016), 2) AS TIV_2016 FROM INSURANCE AS I JOIN T ON I.PID = T.PID WHERE I.TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE GROUP BY 1 HAVING COUNT(TIV_2015) > 1);

/*
Prediction Result:
(1.0,)
*/