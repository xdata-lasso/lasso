-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('C1', 'Sky Radio', 'UK', 'English', 'Music', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('C2', 'Sky Radio', 'Italy', 'Italian', 'Music', '4:3', 'No', 'No', 'Sky Famiglia');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('C3', 'BBC One', 'UK', 'English', 'General', '16:9', 'Yes', 'No', 'Free');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('C4', NULL, 'USA', 'English', 'News', '16:9', 'Yes', 'Yes', 'Premium');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (1.0, 'C1', 'Zebra Tales', 'Dir A', 'Writ Z', '2020-05-01', 105.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (2.0, 'C1', 'Alpha Adventures', 'Dir B', 'Writ Y', '2021-01-01', 101.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (3.0, 'C1', 'Alpha Adventures', 'Dir C', 'Writ X', '2022-01-01', 102.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (4.0, 'C2', NULL, 'Dir D', 'Writ W', '2019-01-01', 100.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (5.0, 'C3', 'Beta Stories', 'Dir E', 'Writ V', '2020-01-01', 103.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (6.0, NULL, 'Gamma World', 'Dir F', 'Writ U', '2020-06-01', 104.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."id" AS "id", "LHS"."series_name" AS "series_name", "LHS"."country" AS "country", "LHS"."language" AS "language", "LHS"."content" AS "content", "LHS"."pixel_aspect_ratio_par" AS "pixel_aspect_ratio_par", "LHS"."hight_definition_tv" AS "hight_definition_tv", "LHS"."pay_per_view_ppv" AS "pay_per_view_ppv", "LHS"."package_option" AS "package_option", "RHS"."id" AS "id_other", "RHS"."title" AS "title", "RHS"."directed_by" AS "directed_by", "RHS"."written_by" AS "written_by", "RHS"."original_air_date" AS "original_air_date", "RHS"."production_code" AS "production_code" FROM (SELECT * FROM "tv_channel" WHERE ("series_name" = 'Sky Radio')) AS LHS INNER JOIN cartoon AS RHS ON (LHS.id = RHS.channel)) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Adventures',)
('Alpha Adventures',)
('Zebra Tales',)
*/

-- Prediction Query
SELECT T2.Title FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T1.series_name = 'Sky Radio';

/*
Prediction Result:
('Zebra Tales',)
('Alpha Adventures',)
('Alpha Adventures',)
(None,)
*/