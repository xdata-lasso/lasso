-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (1, 'Maple Creek', 'Village', 12.5, 1500.0, '10 of 100');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (2, 'Oakridge', 'Town', 45.0, 12000.0, '9 of 100');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (3, 'Pinecrest', 'City', 120.0, 85000.0, '15 of 100');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (4, 'Cedarburg', 'Ward', 30.0, 5000.0, '2 of 100');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (5, 'Birchwood', 'City', 80.0, 40000.0, '15 of 100');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (6, 'Elmhurst', 'Village', 8.0, 900.0, '1 of 100');
INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (1, 2020, 10.0, 5.0, 50.0, 2.0, 3.0, 45.0, 20.0, 30.0);
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (1, 1, 2020, 'Harvest Fest', 'Local Board');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (2, 2, 2021, 'Spring Fair', 'Town Council');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (3, 2, 2022, 'Summer Expo', 'Town Council');
INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (1, 1, 1);
INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (2, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "census_ranking" FROM "city" WHERE ("status" <> 'Village') ORDER BY census_ranking, city.city_id NULLS LAST;

/*
Gold Result:
('15 of 100',)
('15 of 100',)
('2 of 100',)
('9 of 100',)
*/

-- Prediction Query
SELECT Census_Ranking FROM city WHERE Status <> 'Village';

/*
Prediction Result:
('9 of 100',)
('15 of 100',)
('2 of 100',)
('15 of 100',)
*/