-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (1, 'Grandview', 'Town', 45.2, 12000.0, '15 out of 100');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (2, 'Oakridge', 'City', 120.5, 85000.0, '4 out of 100');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (3, 'Riverdale', 'Village', 18.0, 3500.0, '42 out of 100');
INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (1, 2018, 10.0, 8.0, 50.0, 4.0, 2.0, 44.0, 30.0, 60.0);
INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (2, 2019, 20.0, 15.0, 80.0, 6.0, 4.0, 70.0, 50.0, 90.0);
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (10, 2, 2020, 'Crops', 'Alpha Assoc');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (20, 3, 2018, 'Animals', 'Gamma Group');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (30, 1, 2019, 'Bees', 'Beta Board');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (40, 1, 2021, 'Animals', 'Delta Org');
INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (10, 1, 1);
INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (10, 2, 2);
INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (20, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme FROM farm_competition ORDER BY theme, farm_competition.competition_id NULLS LAST;

/*
Gold Result:
('Animals',)
('Animals',)
('Bees',)
('Crops',)
*/

-- Prediction Query
SELECT Theme FROM farm_competition ORDER BY YEAR ASC, farm_competition.competition_id NULLS LAST;

/*
Prediction Result:
('Animals',)
('Bees',)
('Crops',)
('Animals',)
*/