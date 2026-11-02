-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "TV_Channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('yes24', 'yes25', NULL, NULL, NULL, NULL, 'yes36', NULL, 'yes30');
INSERT INTO "TV_Channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('yes31', 'yes32', NULL, NULL, NULL, 'yes40', 'yes36', NULL, 'yes38');
INSERT INTO "TV_series" ("id", "channel", "episode", "air_date", "rating", "share", "18_49_rating_share", "viewers_m", "weekly_rank") VALUES (19, 'yes24', 'yes36', 'yes36', 'yes36', 36, 'yes36', 'yes36', 36);
INSERT INTO "TV_series" ("id", "channel", "episode", "air_date", "rating", "share", "18_49_rating_share", "viewers_m", "weekly_rank") VALUES (18, 'yes24', 'yes36', 'yes36', 'yes36', 36, 'yes36', 'yes36', 36);
INSERT INTO "Cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (21, NULL, 'yes36', 'yes36', 'yes36', 'yes36', 36);
INSERT INTO "Cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (20, NULL, 'yes36', 'yes36', 'yes36', 'yes36', 36);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT pixel_aspect_ratio_par AS package_option, pixel_aspect_ratio_par_other AS series_name FROM (SELECT LHS.id AS id, LHS.series_name AS series_name, LHS.country AS country, LHS.language AS LANGUAGE, LHS.content AS content, LHS.pixel_aspect_ratio_par AS pixel_aspect_ratio_par, LHS.hight_definition_tv AS hight_definition_tv, LHS.pay_per_view_ppv AS pay_per_view_ppv, LHS.package_option AS package_option, RHS.id AS id_other, RHS.series_name AS series_name_other, RHS.country AS country_other, RHS.language AS language_other, RHS.content AS content_other, RHS.pixel_aspect_ratio_par AS pixel_aspect_ratio_par_other, RHS.hight_definition_tv AS hight_definition_tv_other, RHS.pay_per_view_ppv AS pay_per_view_ppv_other, RHS.package_option AS package_option_other FROM tv_channel AS LHS CROSS JOIN tv_channel AS RHS) WHERE (hight_definition_tv = hight_definition_tv_other) ORDER BY package_option, series_name NULLS LAST;

/*
Gold Result:
(None, 'yes40')
(None, None)
('yes40', 'yes40')
('yes40', None)
*/

-- Prediction Query
SELECT package_option, series_name FROM TV_Channel WHERE hight_definition_TV = 'yes';

/*
Prediction Result:
*/