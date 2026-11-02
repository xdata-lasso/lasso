-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (20, 0, 0, 22, 23);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (35, 0, 1, NULL, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH JOIN_LOC AS (SELECT DISTINCT L.PID, L.TIV_2015, L.TIV_2016 FROM INSURANCE AS L LEFT JOIN INSURANCE AS R ON L.PID <> R.PID AND L.LAT = R.LAT AND L.LON = R.LON WHERE R.PID IS NULL), JOIN_2015 AS (SELECT DISTINCT L.PID, L.TIV_2016 FROM JOIN_LOC AS L INNER JOIN INSURANCE AS R ON L.PID <> R.PID AND L.TIV_2015 = R.TIV_2015 WHERE NOT R.TIV_2015 IS NULL) SELECT SUM(TIV_2016) AS TIV_2016 FROM JOIN_2015;

/*
Prediction Result:
(1.0,)
*/