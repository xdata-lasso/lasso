-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('evidence', 'Lisa Brandt', 'Vanuatu', 'notice', 'someone', 'show', 'road', 'deep', 'sell');
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('hour', 'Joseph Martinez', 'Czech Republic', 'attack', 'ground', 'against', 'per', 'once', 'drug');
INSERT INTO "tv_series" ("id", "channel", "episode", "air_date", "rating", "share", "18_49_rating_share", "viewers_m", "weekly_rank") VALUES (1047.5, 'evidence', 'A Love of a Lifetime', 'program', 'account', 1048.5, 'avoid', 'rate', 1049.5);
INSERT INTO "tv_series" ("id", "channel", "episode", "air_date", "rating", "share", "18_49_rating_share", "viewers_m", "weekly_rank") VALUES (1050.5, 'hour', 'A Love of a Lifetime', 'forget', 'inside', 1049.5, 'remain', 'second', 1050.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "air_date" FROM "tv_series" WHERE ("episode" = 'A Love of a Lifetime') ORDER BY air_date, tv_series.id NULLS LAST;

/*
Gold Result:
('forget',)
('program',)
*/

-- Prediction Query
SELECT Air_Date FROM TV_series WHERE Episode = 'A Love of a Lifetime';

/*
Prediction Result:
('program',)
('forget',)
*/