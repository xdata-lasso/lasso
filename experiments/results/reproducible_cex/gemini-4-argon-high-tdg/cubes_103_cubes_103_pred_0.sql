-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('CH1', 'Drama Central', 'USA', 'English', 'Drama', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('CH2', 'Comedy Plus', 'UK', 'English', 'Comedy', '4:3', 'No', 'Yes', 'Premium');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (10.0, 'CH1', 'A Love of a Lifetime', '2020-01-15', '8.5', 14.0, '2.1/6', '11.2', 25.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (20.0, 'CH2', 'A Love of a Lifetime', '2020-02-20', '9.1', 18.0, '3.0/8', '15.4', 4.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (30.0, 'CH1', 'a love of a lifetime', '2020-03-10', '7.2', 11.0, '1.5/4', '8.0', 50.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (40.0, 'CH1', 'A Love of a Lifetime Part 2', '2020-03-17', '7.8', 12.5, '1.8/5', '9.5', 33.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (50.0, 'CH2', 'The Final Curtain', '2020-04-01', '6.5', 9.0, '1.1/3', '5.1', 80.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (1.0, 'CH1', 'Toon World', 'Alice Smith', 'Bob Jones', '2019-05-01', 101.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "weekly_rank" FROM "tv_series" WHERE ("episode" = 'A Love of a Lifetime') ORDER BY weekly_rank, tv_series.id NULLS LAST;

/*
Gold Result:
(4.0,)
(25.0,)
*/

-- Prediction Query
SELECT Weekly_Rank FROM TV_series WHERE Episode = 'A Love of a Lifetime';

/*
Prediction Result:
(25.0,)
(4.0,)
*/