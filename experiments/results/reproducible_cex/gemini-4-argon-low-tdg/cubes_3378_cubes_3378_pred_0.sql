-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (1, 'Metropolis', 'Town', 100.0, 5000.0, '10th');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (2, 'Gotham', 'Village', 50.0, 2000.0, '20th');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (3, 'Star City', 'Village', 60.0, 2500.0, '15th');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (4, 'Central City', 'City', 200.0, 10000.0, '1st');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (5, 'Coast City', 'City', 180.0, 9000.0, '2nd');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (6, 'National City', 'City', 150.0, 8000.0, '3rd');
INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (1, 2020, 10.0, 5.0, 20.0, 2.0, 1.0, 17.0, 30.0, 40.0);
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (1, 1, 2020, 'Spring', 'Host A');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (2, 1, 2021, 'Summer', 'Host B');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (3, 1, 2022, 'Autumn', 'Host C');
INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT status FROM (SELECT * FROM (SELECT * FROM (SELECT status, MAX(n) AS maxn FROM (SELECT city_id, status, COUNT(*) AS n FROM city GROUP BY city_id, status) GROUP BY status) ORDER BY status DESC) LIMIT 1);

/*
Gold Result:
('Village',)
*/

-- Prediction Query
SELECT Status FROM city GROUP BY Status ORDER BY COUNT(*) DESC, Status NULLS LAST LIMIT 1;

/*
Prediction Result:
('City',)
*/