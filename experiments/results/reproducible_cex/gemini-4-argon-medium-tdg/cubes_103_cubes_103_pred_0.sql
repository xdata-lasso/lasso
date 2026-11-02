-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('C1', 'Series 1', 'USA', 'English', 'Drama', '16:9', 'Yes', 'No', 'Standard');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (1.0, 'C1', 'A Love of a Lifetime', '2020-01-01', '8.5', 12.0, '2.5/8', '10.5', 45.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (2.0, 'C1', 'A Love of a Lifetime', '2020-01-08', '8.0', 10.0, '2.0/6', '9.0', 12.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (3.0, 'C1', 'A Love of a Lifetime', '2020-01-15', '8.2', 11.0, '2.2/7', '9.5', 12.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (4.0, 'C1', 'Other Episode', '2020-01-22', '7.5', 9.0, '1.8/5', '8.0', 5.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (5.0, 'C1', 'a love of a lifetime', '2020-01-29', '7.0', 8.0, '1.5/4', '7.0', 1.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (6.0, 'C1', NULL, '2020-02-05', '6.5', 7.0, '1.2/3', '6.0', 99.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "weekly_rank" FROM "tv_series" WHERE ("episode" = 'A Love of a Lifetime') ORDER BY weekly_rank, tv_series.id NULLS LAST;

/*
Gold Result:
(12.0,)
(12.0,)
(45.0,)
*/

-- Prediction Query
SELECT Weekly_Rank FROM TV_series WHERE Episode = 'A Love of a Lifetime';

/*
Prediction Result:
(45.0,)
(12.0,)
(12.0,)
*/