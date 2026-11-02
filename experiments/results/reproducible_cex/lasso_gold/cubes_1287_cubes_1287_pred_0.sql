-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1001, 'Allison Hill', 1005, 1009, '863 Lawrence Valleys
Port Lindachester, MA 36922');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1002, 'Noah Rhodes', 1012.0, 1018.0, '16155 Roman Stream Suite 816
New Kellystad, OK 25704');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1003, 'Angie Henderson', 1019.0, 1027.0, '341 Michelle Light
Shawnstad, GA 49021');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1004, 'Daniel Wagner', 1026.0, 1036.0, '192 Frank Light Suite 835
East Lydiamouth, MO 35594');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM (SELECT * FROM (SELECT * FROM cinema ORDER BY LOCATION DESC, cinema.cinema_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Allison Hill', '863 Lawrence Valleys\nPort Lindachester, MA 36922')
*/

-- Prediction Query
SELECT name, LOCATION FROM cinema ORDER BY capacity DESC, cinema.cinema_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Daniel Wagner', '192 Frank Light Suite 835\nEast Lydiamouth, MO 35594')
*/