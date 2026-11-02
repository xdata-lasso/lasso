-- Schema DDL
CREATE TABLE "storm" ("Storm_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Dates_active" TEXT, "Max_speed" INTEGER, "Damage_millions_USD" REAL, "Number_Deaths" INTEGER);

CREATE TABLE "region" ("Region_id" INTEGER PRIMARY KEY, "Region_code" TEXT, "Region_name" TEXT);

CREATE TABLE "affected_region" ("Region_id" INTEGER, "Storm_ID" INTEGER, "Number_city_affected" REAL, PRIMARY KEY ("Region_id", "Storm_ID"), FOREIGN KEY ("Storm_ID") REFERENCES "storm" ("Storm_ID"), FOREIGN KEY ("Region_id") REFERENCES "region" ("Region_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO storm (Storm_ID, Name, Dates_active, Max_speed, Damage_millions_USD, Number_Deaths) VALUES (1, 'Storm A', '2023-01-01', 100, 1.0, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT * FROM storm WHERE (number_deaths <> 0))) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM storm WHERE Number_Deaths > 0;

/*
Prediction Result:
(0,)
*/