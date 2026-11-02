-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('put', 'Sky Radio', 'Guam', 'brother', 'finally', 'learn', 'coach', 'long', 'about');
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('hour', 'Sky Radio', 'Serbia', 'color', 'notice', 'start', 'win', 'nice', 'why');
INSERT INTO "cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (1032.5, 'put', 'General practice doctor', 'month', 'sound', 'could', 1033.5);
INSERT INTO "cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (1034.5, 'put', 'Runner, broadcasting/film/video', 'politics', 'decide', 'claim', 1035.5);
INSERT INTO "cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (1036.5, 'hour', 'Academic librarian', 'place', 'game', 'middle', 1037.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."id" AS "id", "LHS"."series_name" AS "series_name", "LHS"."country" AS "country", "LHS"."language" AS "language", "LHS"."content" AS "content", "LHS"."pixel_aspect_ratio_par" AS "pixel_aspect_ratio_par", "LHS"."hight_definition_tv" AS "hight_definition_tv", "LHS"."pay_per_view_ppv" AS "pay_per_view_ppv", "LHS"."package_option" AS "package_option", "RHS"."id" AS "id_other", "RHS"."title" AS "title", "RHS"."directed_by" AS "directed_by", "RHS"."written_by" AS "written_by", "RHS"."original_air_date" AS "original_air_date", "RHS"."production_code" AS "production_code" FROM (SELECT * FROM "tv_channel" WHERE ("series_name" = 'Sky Radio')) AS LHS INNER JOIN cartoon AS RHS ON (LHS.id = RHS.channel)) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Academic librarian',)
('General practice doctor',)
('Runner, broadcasting/film/video',)
*/

-- Prediction Query
SELECT T2.Title FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T1.series_name = 'Sky Radio';

/*
Prediction Result:
('General practice doctor',)
('Runner, broadcasting/film/video',)
('Academic librarian',)
*/