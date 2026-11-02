-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-416, 797, 1, NULL, 17);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-417, 797, NULL, NULL, 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH GET_UNIQUES_LL AS (SELECT LAT, LON, MIN(PID) AS UID FROM INSURANCE GROUP BY 1, 2 HAVING COUNT(*) <= 1), GET_SAME_TIV AS (SELECT DISTINCT I1.PID, I1.TIV_2016 FROM INSURANCE AS I1 INNER JOIN INSURANCE AS I2 ON I1.PID <> I2.PID AND I1.TIV_2015 = I2.TIV_2015) SELECT ROUND(SUM(T1.TIV_2016), 2) AS TIV_2016 FROM GET_SAME_TIV AS T1 INNER JOIN GET_UNIQUES_LL AS T2 ON T1.PID = T2.UID;

/*
Prediction Result:
(1.0,)
*/