-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic matching, non-matching episodes, case sensitivity, substring matching, and NULL episodes.
-- Also tests foreign key relationship vs NULL foreign key (to kill unnecessary INNER JOIN mutants).
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('CH1', 'Drama Central', 'USA', 'English', 'Drama', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (1.0, 'CH1', 'A Love of a Lifetime', '2021-05-10', '8.5', 12.0, '2.1/6', '5.4', 10.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (2.0, NULL, 'A Love of a Lifetime', '2020-01-15', '7.9', 10.5, '1.8/5', '4.2', 15.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (3.0, 'CH1', 'a love of a lifetime', '2019-11-20', '6.5', 8.0, '1.2/4', '3.1', 25.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (4.0, 'CH1', 'A Love of a Lifetime Part 2', '2022-03-01', '9.0', 15.0, '3.0/8', '7.0', 5.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (5.0, 'CH1', 'Another Episode', '2021-05-10', '7.0', 9.0, '1.5/5', '3.8', 20.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (6.0, 'CH1', NULL, '2023-01-01', '5.0', 6.0, '0.8/2', '1.5', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "air_date" FROM "tv_series" WHERE ("episode" = 'A Love of a Lifetime') ORDER BY air_date, tv_series.id NULLS LAST;

/*
Gold Result:
('2020-01-15',)
('2021-05-10',)
*/

-- Prediction Query
SELECT Air_Date FROM TV_series WHERE Episode = 'A Love of a Lifetime';

/*
Prediction Result:
('2021-05-10',)
('2020-01-15',)
*/