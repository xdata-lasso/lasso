-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO city (city_id, official_name, status, area_km_2, population, census_ranking) VALUES (1500, 'default2', NULL, 0.0, 1499.0, 'default2'), (1, NULL, 'default2', 1499.0, 501.0, 'default2'), (500, 'default2', NULL, 1500.0, 1.0, 'default2'), (499, 'default1', NULL, 1499.0, 1501.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT official_name FROM city WHERE (population >= 1500.0 OR population < 500.0) ORDER BY official_name, city.city_id NULLS LAST;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Official_Name FROM city WHERE Population > 1500 OR Population < 500;

/*
Prediction Result:
('default1',)
('default2',)
*/