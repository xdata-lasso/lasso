-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Basic DISTINCT, ORDER BY ASC vs DESC vs no ORDER BY, column confusion, and INNER JOIN mutants with farm_competition
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (1, 'Alpha', 'Town', 120.5, 5000.0, '3rd');
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (2, 'Beta', 'City', 450.0, 150000.0, '1st');
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (3, 'Gamma', 'Town', 85.0, 3200.0, '4th');
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (4, 'Delta', 'Village', 15.2, 500.0, '5th');
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (5, 'Epsilon', 'Metropolis', 1200.0, 1000000.0, '2nd');
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (101, 1, 2020, 'Harvest', 'Farmers Union');
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (102, 2, 2021, 'Livestock', 'Dairy Assoc');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status FROM city ORDER BY status;

/*
Gold Result:
('City',)
('Metropolis',)
('Town',)
('Village',)
*/

-- Prediction Query
SELECT Status FROM city GROUP BY Status ORDER BY COUNT(*) ASC, Status NULLS LAST;

/*
Prediction Result:
('City',)
('Metropolis',)
('Village',)
('Town',)
*/