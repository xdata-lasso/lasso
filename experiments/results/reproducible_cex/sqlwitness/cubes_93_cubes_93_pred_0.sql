-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO tv_channel (id, series_name, country, language, content, pixel_aspect_ratio_par, hight_definition_tv, pay_per_view_ppv, package_option) VALUES ('default1', 'default1', 'default1', 'Sky Radio', 'default2', 'Sky Radio', 'Sky Radio', 'default2', NULL), ('default2', 'Sky Radio', NULL, NULL, 'default2', 'Sky Radio', 'default2', 'default1', 'default1'), ('Sky Radio', 'default2', 'Sky Radio', 'default2', NULL, NULL, 'Sky Radio', 'Sky Radio', 'Sky Radio'), ('unique_3', 'Sky Radio', NULL, 'default1', 'Sky Radio', 'default1', 'Sky Radio', 'Sky Radio', 'default1'), ('unique_4', 'Sky Radio', NULL, 'default1', NULL, 'default1', 'default1', 'Sky Radio', 'Sky Radio'), ('unique_5', 'Sky Radio', 'default2', 'default1', 'default1', 'Sky Radio', 'default2', 'default2', 'Sky Radio'), ('unique_6', 'default2', 'Sky Radio', 'default1', NULL, 'default2', 'default1', 'default2', 'default2'), ('unique_7', NULL, 'default1', 'default2', 'default1', 'default2', 'default1', 'default1', NULL), ('unique_8', 'Sky Radio', NULL, NULL, 'default1', 'default2', 'default2', NULL, NULL), ('unique_9', NULL, 'default1', 'Sky Radio', 'default2', NULL, 'default1', 'default2', NULL), ('unique_10', 'default2', 'Sky Radio', NULL, 'default2', 'default2', 'Sky Radio', NULL, 'default2'), ('unique_11', 'Sky Radio', 'Sky Radio', 'default1', 'default1', NULL, 'Sky Radio', 'default1', 'default2'), ('unique_12', 'default1', 'Sky Radio', NULL, 'default2', NULL, 'default1', 'default2', NULL), ('unique_13', 'default1', 'default2', 'default2', 'Sky Radio', 'default2', 'default2', NULL, 'default1'), ('unique_14', 'Sky Radio', 'Sky Radio', 'Sky Radio', 'default2', NULL, 'Sky Radio', 'default1', 'default1'), ('unique_15', NULL, NULL, 'Sky Radio', 'Sky Radio', 'default1', 'Sky Radio', 'default1', NULL);
INSERT INTO cartoon (id, channel, title, directed_by, written_by, original_air_date, production_code) VALUES (0.0, 'unique_8', 'default2', 'default2', NULL, 'Sky Radio', 1.0), (1.0, 'unique_5', 'Sky Radio', 'default2', 'default1', NULL, NULL), (20000.0, 'unique_5', 'default1', 'default1', 'default1', 'Sky Radio', 0.0), (40000.0, 'unique_9', 'Sky Radio', 'default1', NULL, 'Sky Radio', 1.0), (60000.0, 'unique_4', 'default2', NULL, NULL, 'default1', 0.0), (80000.0, 'unique_11', 'Sky Radio', NULL, 'default1', 'Sky Radio', 0.0), (100000.0, 'unique_9', NULL, NULL, 'default2', 'Sky Radio', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."id" AS "id", "LHS"."series_name" AS "series_name", "LHS"."country" AS "country", "LHS"."language" AS "language", "LHS"."content" AS "content", "LHS"."pixel_aspect_ratio_par" AS "pixel_aspect_ratio_par", "LHS"."hight_definition_tv" AS "hight_definition_tv", "LHS"."pay_per_view_ppv" AS "pay_per_view_ppv", "LHS"."package_option" AS "package_option", "RHS"."id" AS "id_other", "RHS"."title" AS "title", "RHS"."directed_by" AS "directed_by", "RHS"."written_by" AS "written_by", "RHS"."original_air_date" AS "original_air_date", "RHS"."production_code" AS "production_code" FROM (SELECT * FROM "tv_channel" WHERE ("series_name" = 'Sky Radio')) AS LHS INNER JOIN cartoon AS RHS ON (LHS.id = RHS.channel)) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Sky Radio',)
('Sky Radio',)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT T2.Title FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T1.series_name = 'Sky Radio';

/*
Prediction Result:
('default2',)
('Sky Radio',)
('default1',)
('default2',)
('Sky Radio',)
*/