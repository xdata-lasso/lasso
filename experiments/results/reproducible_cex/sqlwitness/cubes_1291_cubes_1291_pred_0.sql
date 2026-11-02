-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (cinema_id, name, openning_year, capacity, location) VALUES (1, 'default2', 1, 800, 'default2'), (799, 'default2', 799, 800, 'default2'), (801, 'default1', 799, 800, 'default1'), (0, NULL, 801, NULL, NULL), (800, 'default2', NULL, 801, 'default1'), (2, 'default1', 800, 799, 'default1'), (3, 'default1', 801, 801, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT * FROM cinema AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM cinema WHERE (capacity >= 800)) AS RHS WHERE (LHS.location = RHS.location))) ORDER BY LOCATION;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT LOCATION FROM cinema EXCEPT SELECT LOCATION FROM cinema WHERE capacity > 800;

/*
Prediction Result:
(None,)
('default2',)
*/