-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (1, 'Grand Falls', 'Town', 18.06, 5706.0, '636 of 5008');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (2, 'Corner Brook', 'City', 148.27, 19806.0, '193 of 5008');
INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (1, 1990, 50.0, 20.0, 100.0, 10.0, 5.0, 85.0, 30.0, 40.0);
INSERT INTO farm (Farm_ID, Year, Total_Horses, Working_Horses, Total_Cattle, Oxen, Bulls, Cows, Pigs, Sheep_and_Goats) VALUES (2, 1995, 60.0, 25.0, 120.0, 12.0, 6.0, 102.0, 35.0, 45.0);
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (1, 1, 2005, 'Carnival', 'Zoe Saldana');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (2, 2, 2001, 'Aliens', 'Bono');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (3, 1, 2010, 'Agriculture', 'Miley Cyrus');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (4, 2, 2008, 'Harvest', 'Adam Levine');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (5, 1, 2012, 'Valentine''s Day', 'Miley Cyrus');
INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (1, 1, 1);
INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (2, 1, 2);
INSERT INTO competition_record (Competition_ID, Farm_ID, Rank) VALUES (3, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "hosts" FROM "farm_competition" WHERE ("theme" <> 'Aliens') ORDER BY hosts, farm_competition.competition_id NULLS LAST;

/*
Gold Result:
('Adam Levine',)
('Miley Cyrus',)
('Miley Cyrus',)
('Zoe Saldana',)
*/

-- Prediction Query
SELECT Hosts FROM farm_competition WHERE Theme <> 'Aliens';

/*
Prediction Result:
('Zoe Saldana',)
('Miley Cyrus',)
('Adam Levine',)
('Miley Cyrus',)
*/