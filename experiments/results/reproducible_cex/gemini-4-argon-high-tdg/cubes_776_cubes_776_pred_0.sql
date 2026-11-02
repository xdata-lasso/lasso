-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (1, 'Zeta Valley', 'Village', 120.5, 250.0, '7th');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (2, 'Alpha Springs', 'Village', 85.0, 499.9, '6th');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (3, 'Beta Ridge', 'Hamlet', 310.0, 500.0, '5th');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (4, 'Gamma Creek', 'Town', 45.2, 500.1, '4th');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (5, 'Delta Harbor', 'Town', 95.8, 1200.0, '3rd');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (6, 'Epsilon Peak', 'Suburb', 210.0, 1499.9, '2nd');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (7, 'Omega Bay', 'City', 500.0, 1500.0, '1st');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (8, 'Sigma Plains', 'Metropolis', 1200.0, 3500.0, '8th');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (9, 'Theta Marsh', 'Unincorporated', 60.0, NULL, '9th');
INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (1, 2020, 50.0, 20.0, 100.0, 10.0, 5.0, 85.0, 40.0, 60.0);
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (1, 1, 2020, 'Harvest Fest', 'Zeta Committee');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (2, 7, 2021, 'Dairy Expo', 'Omega Council');
INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status FROM city WHERE (population < 1500.0 OR population <= 500.0) ORDER BY status;

/*
Gold Result:
('Hamlet',)
('Suburb',)
('Town',)
('Village',)
*/

-- Prediction Query
SELECT Status FROM city WHERE Population > 1500 INTERSECT SELECT Status FROM city WHERE Population < 500;

/*
Prediction Result:
*/