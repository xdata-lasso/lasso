-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "TV_Channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('English10', 'English14', NULL, 'English13', 'English15', 'English27', 'English16', 'English17', 'English18');
INSERT INTO "TV_Channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('English9', 'English20', NULL, 'English19', 'English21', 'English27', 'English22', 'English23', 'English24');
INSERT INTO "TV_series" ("id", "channel", "episode", "air_date", "rating", "share", "18_49_rating_share", "viewers_m", "weekly_rank") VALUES (12, 'English10', 'English27', 'English27', 'English27', 27, 'English27', 'English27', 27);
INSERT INTO "TV_series" ("id", "channel", "episode", "air_date", "rating", "share", "18_49_rating_share", "viewers_m", "weekly_rank") VALUES (11, 'English9', 'English27', 'English27', 'English27', 27, 'English27', 'English27', 27);
INSERT INTO "Cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (27, 'English9', 'English27', 'English27', 'English27', 'English27', 27);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" AS "pixel_aspect_ratio_par", "pixel_aspect_ratio_par" AS "country" FROM "tv_channel" WHERE ("language" <> 'English') ORDER BY pixel_aspect_ratio_par, tv_channel.id NULLS LAST;

/*
Gold Result:
(None, 'English27')
(None, 'English27')
*/

-- Prediction Query
SELECT Pixel_aspect_ratio_PAR, country FROM tv_channel WHERE LANGUAGE <> 'English';

/*
Prediction Result:
('English27', None)
('English27', None)
*/