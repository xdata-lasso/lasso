-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "TV_Channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('Sky Radio10', 'Sky Radio15', NULL, NULL, 'Sky Radio28', NULL, NULL, NULL, NULL);
INSERT INTO "TV_Channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('Sky Radio9', 'Sky Radio', 'Sky Radio22', 'Sky Radio23', 'Sky Radio29', 'Sky Radio24', 'Sky Radio25', 'Sky Radio26', 'Sky Radio27');
INSERT INTO "TV_series" ("id", "channel", "episode", "air_date", "rating", "share", "18_49_rating_share", "viewers_m", "weekly_rank") VALUES (12, 'Sky Radio9', 'Sky Radio9', 'Sky Radio9', 'Sky Radio9', 9, 'Sky Radio9', 'Sky Radio9', 9);
INSERT INTO "TV_series" ("id", "channel", "episode", "air_date", "rating", "share", "18_49_rating_share", "viewers_m", "weekly_rank") VALUES (11, 'Sky Radio9', 'Sky Radio9', 'Sky Radio9', 'Sky Radio9', 9, 'Sky Radio9', 'Sky Radio9', 9);
INSERT INTO "Cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (14, 'Sky Radio9', 'Sky Radio9', 'Sky Radio9', 'Sky Radio9', 'Sky Radio9', 9);
INSERT INTO "Cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (13, 'Sky Radio9', 'Sky Radio9', 'Sky Radio9', 'Sky Radio9', 'Sky Radio9', 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "content" FROM "tv_channel" WHERE ("series_name" <> 'Sky Radio') ORDER BY content, "content" NULLS LAST;

/*
Gold Result:
('Sky Radio28',)
*/

-- Prediction Query
SELECT Content FROM TV_Channel WHERE series_name = 'Sky Radio';

/*
Prediction Result:
('Sky Radio29',)
*/