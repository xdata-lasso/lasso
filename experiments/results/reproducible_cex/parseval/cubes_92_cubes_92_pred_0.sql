-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: tv_channel --
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('lhs_51ea10', 'lhs_6ae428', 'lhs_549da3', 'lhs_0ac91a', 'lhs_9eb98f', 'lhs_39064e', 'lhs_41eeab', 'lhs_9203c2', 'lhs_8d2069');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('_', 'lhs_6ae428', 'lhs_549da3', 'lhs_0ac91a', 'lhs_9eb98f', 'lhs_39064e', 'lhs_41eeab', 'lhs_9203c2', 'lhs_8d2069');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('A', 'hria2ypu', 'hsrwbbp', 'luhvdltti', 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('@', 'lhs_6ae428', 'lhs_549da3', 'lhs_0ac91a', 'lhs_9eb98f', 'lhs_39064e', 'lhs_41eeab', 'lhs_9203c2', 'lhs_8d2069');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('G', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('!', 'lhs_6ae428', 'lhs_549da3', 'lhs_0ac91a', 'lhs_9eb98f', 'lhs_39064e', 'lhs_41eeab', 'lhs_9203c2', 'lhs_8d2069');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('rhs_18fd46', 'lhs_6ae428', 'lhs_549da3', 'lhs_0ac91a', 'lhs_9eb98f', 'lhs_39064e', 'lhs_41eeab', 'lhs_9203c2', 'lhs_8d2069');

-- Inserting into table: cartoon --
INSERT INTO "cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (1.0, 'lhs_51ea10', '5sw', 'qcgsk9', '8c4p', 'u7', 328.996339);

INSERT INTO "cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (433.533777, 'rhs_18fd46', 'rhs_96e359', 'rhs_456561', 'rhs_1c3c5e', 'rhs_21bd35', 1.0);

INSERT INTO "cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (998.887019, 'rhs_18fd46', 'rhs_96e359', 'rhs_456561', 'rhs_1c3c5e', 'rhs_21bd35', 1.0);

INSERT INTO "cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (326.912005, 'rhs_18fd46', 'rhs_96e359', 'rhs_456561', 'rhs_1c3c5e', 'rhs_21bd35', 1.0);

INSERT INTO "cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (541.066766, 'rhs_18fd46', 'rhs_96e359', 'rhs_456561', 'rhs_1c3c5e', 'rhs_21bd35', 1.0);

INSERT INTO "cartoon" ("id", "channel", "title", "directed_by", "written_by", "original_air_date", "production_code") VALUES (557.003843, 'rhs_18fd46', 'rhs_96e359', 'rhs_456561', 'rhs_1c3c5e', 'rhs_21bd35', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "country" FROM (SELECT "id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option", "id_other", "title", "directed_by", "written_by", "original_air_date", "production_code", "id" AS "channel" FROM (SELECT "LHS"."id" AS "id", "LHS"."series_name" AS "series_name", "LHS"."country" AS "country", "LHS"."language" AS "language", "LHS"."content" AS "content", "LHS"."pixel_aspect_ratio_par" AS "pixel_aspect_ratio_par", "LHS"."hight_definition_tv" AS "hight_definition_tv", "LHS"."pay_per_view_ppv" AS "pay_per_view_ppv", "LHS"."package_option" AS "package_option", "RHS"."id" AS "id_other", "RHS"."title" AS "title", "RHS"."directed_by" AS "directed_by", "RHS"."written_by" AS "written_by", "RHS"."original_air_date" AS "original_air_date", "RHS"."production_code" AS "production_code" FROM "tv_channel" AS "LHS" INNER JOIN "cartoon" AS "RHS" ON ("LHS"."id" = "RHS"."channel"))) WHERE ("written_by" <> 'Todd Casey') ORDER BY country, "country" NULLS LAST;

/*
Gold Result:
('lhs_549da3',)
*/

-- Prediction Query
SELECT T1.country FROM TV_Channel AS T1 JOIN cartoon AS T2 ON T1.id = T2.Channel WHERE T2.written_by = 'Todd Casey';

/*
Prediction Result:
*/