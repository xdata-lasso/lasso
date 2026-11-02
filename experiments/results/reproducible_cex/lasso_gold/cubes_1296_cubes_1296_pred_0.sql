-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1020, 'Amy Jones', 1021, 1022, 'Unit 2814 Box 8932
DPO AA 21675');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1023, 'Nathan Cortez', 1021, 1025, '0154 Brian Wells Apt. 171
East Donna, OH 22144');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1026, 'Leah Smith', 1022, 1028, '465 Lam Mission
East Jeffreymouth, AK 77611');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, openning_year FROM cinema ORDER BY name, cinema.cinema_id NULLS LAST;

/*
Gold Result:
('Amy Jones', 1021)
('Leah Smith', 1022)
('Nathan Cortez', 1021)
*/

-- Prediction Query
SELECT name, openning_year FROM cinema ORDER BY openning_year DESC, cinema.cinema_id NULLS LAST;

/*
Prediction Result:
('Leah Smith', 1022)
('Amy Jones', 1021)
('Nathan Cortez', 1021)
*/