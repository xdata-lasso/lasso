-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1008, 'Kimberly Dudley', 1009, 1010, '959 Janet Cape Apt. 413
South Joshuastad, GA 49021');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1011, 'Michael Miles', 1010, 1011, '6413 Lewis Parks
Wilkersonmouth, FL 35219');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM cinema ORDER BY LOCATION;

/*
Gold Result:
('6413 Lewis Parks\nWilkersonmouth, FL 35219',)
('959 Janet Cape Apt. 413\nSouth Joshuastad, GA 49021',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM cinema;

/*
Prediction Result:
('959 Janet Cape Apt. 413\nSouth Joshuastad, GA 49021',)
('6413 Lewis Parks\nWilkersonmouth, FL 35219',)
*/