-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic selection, duplicate retention (SELECT vs SELECT DISTINCT), ordering by Air_Date, and false matches in other columns/tables.
INSERT INTO "TV_Channel" ("id", "series_name") VALUES ('C1', 'A Love of a Lifetime');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating") VALUES (1.0, 'C1', 'A Love of a Lifetime', '2007-10-15', '5.0');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating") VALUES (2.0, 'C1', 'A Love of a Lifetime', '2007-09-24', '6.0');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating") VALUES (3.0, 'C1', 'A Love of a Lifetime', '2007-09-24', '7.0');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating") VALUES (4.0, 'C1', 'Other Episode', '2007-01-01', 'A Love of a Lifetime');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Original_air_date") VALUES (1.0, 'C1', 'A Love of a Lifetime', '1999-05-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "air_date" FROM "tv_series" WHERE ("episode" = 'A Love of a Lifetime') ORDER BY air_date, tv_series.id NULLS LAST;

/*
Gold Result:
('2007-09-24',)
('2007-09-24',)
('2007-10-15',)
*/

-- Prediction Query
SELECT Air_Date FROM TV_series WHERE Episode = 'A Love of a Lifetime';

/*
Prediction Result:
('2007-10-15',)
('2007-09-24',)
('2007-09-24',)
*/