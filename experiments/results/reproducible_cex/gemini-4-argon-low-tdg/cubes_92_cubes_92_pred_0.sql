-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inequality vs anti-join, DISTINCT elimination, ordering, and NULL handling.
-- C1 (USA) has both a 'Todd Casey' cartoon and another writer (kills EXCEPT/NOT IN mutants).
-- C2 (Canada) has ONLY 'Todd Casey' (kills missing WHERE or '=' instead of '<>' mutants).
-- C3 (Mexico) has multiple valid cartoons (kills missing DISTINCT mutants).
-- C4 (France) has NO cartoons (kills LEFT JOIN mutants).
-- C5 (NULL Country) has a valid cartoon (kills NULLS FIRST or IS NOT NULL mutants).
-- C6 (Japan) has a cartoon with NULL writer (kills IS DISTINCT FROM / COALESCE mutants).
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('C1', 'Series1', 'USA', 'English', 'Cartoons', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('C2', 'Series2', 'Canada', 'English', 'Cartoons', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('C3', 'Series3', 'Mexico', 'Spanish', 'Cartoons', '4:3', 'No', 'No', 'Standard');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('C4', 'Series4', 'France', 'French', 'News', '16:9', 'Yes', 'Yes', 'Premium');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('C5', 'Series5', NULL, 'English', 'Music', '16:9', 'No', 'No', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('C6', 'Series6', 'Japan', 'Japanese', 'Anime', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (1.0, 'C1', 'Toon 1', 'Dir A', 'Todd Casey', '2020-01-01', 101.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (2.0, 'C1', 'Toon 2', 'Dir B', 'John Doe', '2020-01-02', 102.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (3.0, 'C2', 'Toon 3', 'Dir A', 'Todd Casey', '2020-01-03', 103.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (4.0, 'C3', 'Toon 4', 'Dir C', 'Jane Roe', '2020-01-04', 104.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (5.0, 'C3', 'Toon 5', 'Dir C', 'Bob Smith', '2020-01-05', 105.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (6.0, 'C5', 'Toon 6', 'Dir D', 'Alice Wong', '2020-01-06', 106.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (7.0, 'C6', 'Toon 7', 'Dir E', NULL, '2020-01-07', 107.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "country" FROM (SELECT "id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option", "id_other", "title", "directed_by", "written_by", "original_air_date", "production_code", "id" AS "channel" FROM (SELECT "LHS"."id" AS "id", "LHS"."series_name" AS "series_name", "LHS"."country" AS "country", "LHS"."language" AS "language", "LHS"."content" AS "content", "LHS"."pixel_aspect_ratio_par" AS "pixel_aspect_ratio_par", "LHS"."hight_definition_tv" AS "hight_definition_tv", "LHS"."pay_per_view_ppv" AS "pay_per_view_ppv", "LHS"."package_option" AS "package_option", "RHS"."id" AS "id_other", "RHS"."title" AS "title", "RHS"."directed_by" AS "directed_by", "RHS"."written_by" AS "written_by", "RHS"."original_air_date" AS "original_air_date", "RHS"."production_code" AS "production_code" FROM "tv_channel" AS "LHS" INNER JOIN "cartoon" AS "RHS" ON ("LHS"."id" = "RHS"."channel"))) WHERE ("written_by" <> 'Todd Casey') ORDER BY country, "country" NULLS LAST;

/*
Gold Result:
(None,)
('Mexico',)
('USA',)
*/

-- Prediction Query
SELECT T1.country FROM TV_Channel AS T1 JOIN cartoon AS T2 ON T1.id = T2.Channel WHERE T2.written_by = 'Todd Casey';

/*
Prediction Result:
('USA',)
('Canada',)
*/