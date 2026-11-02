-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (1, 'Gotham', 'City', 250.0, 100000.0, '2nd');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (2, 'Starling', 'Town', 50.0, 15000.0, '10th');
INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (1, 1995, 5.0, 2.0, 10.0, 1.0, 1.0, 8.0, 15.0, 20.0);
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (1, 2, 2015, 'Corn', 'John');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (2, 1, 2018, 'Wheat', 'Alice');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (3, 1, 2010, 'Apple', 'Bob');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (4, 2, 2012, 'Dairy', 'Charlie');
INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (1, 1, 1);
INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (2, 1, 2);
INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (3, 1, 1);
INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (4, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme FROM farm_competition ORDER BY theme, farm_competition.competition_id NULLS LAST;

/*
Gold Result:
('Apple',)
('Corn',)
('Dairy',)
('Wheat',)
*/

-- Prediction Query
SELECT Theme FROM farm_competition ORDER BY YEAR ASC, farm_competition.competition_id NULLS LAST;

/*
Prediction Result:
('Apple',)
('Dairy',)
('Corn',)
('Wheat',)
*/