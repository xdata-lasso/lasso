-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (cinema_id, name, openning_year, capacity, location) VALUES (2, NULL, NULL, 0, 'default1'), (1, NULL, 0, 0, 'default1'), (0, 'default2', 2, 0, NULL), (3, NULL, 2, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM (SELECT * FROM (SELECT * FROM cinema ORDER BY LOCATION DESC, cinema.cinema_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(None, 'default1')
*/

-- Prediction Query
SELECT name, LOCATION FROM cinema ORDER BY capacity DESC, cinema.cinema_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, None)
*/