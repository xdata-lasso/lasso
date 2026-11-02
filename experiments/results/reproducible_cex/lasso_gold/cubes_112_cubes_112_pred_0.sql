-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('Congress', 'Danielle Ford', 'Faroe Islands', 'wish', 'push', 'rise', 'onto', 'discuss', 'reveal');
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('arrive', 'Andrew Stewart', 'Ethiopia', 'attorney', 'development', 'white', 'yes', 'our', 'under');
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('individual', 'Maria Thomas', 'Burundi', 'employee', 'size', 'option', 'nothing', 'everyone', 'skin');
INSERT INTO "cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (1014.5, 'Congress', 'Journalist, broadcasting', 'inside', 'special', 'stand', 1015.5);
INSERT INTO "cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (1016.5, 'arrive', 'International aid/development worker', 'inside', 'reality', 'money', 1017.5);
INSERT INTO "cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (1018.5, 'individual', 'Television/film/video producer', 'threat', 'water', 'past', 1019.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, directed_by FROM (SELECT directed_by, COUNT(*) AS n FROM cartoon GROUP BY directed_by) ORDER BY count___, directed_by NULLS LAST;

/*
Gold Result:
(1, 'threat')
(2, 'inside')
*/

-- Prediction Query
SELECT COUNT(*), Directed_by FROM cartoon GROUP BY Directed_by;

/*
Prediction Result:
(2, 'inside')
(1, 'threat')
*/