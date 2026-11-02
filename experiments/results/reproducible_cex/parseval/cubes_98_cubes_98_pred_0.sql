-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: tv_channel --
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('A', 'tv__b2276b', '5k5swwqcgs', '9n8', 'tv__2d27f7', '4', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('C', 'tv__3f030f', 'rwbbp6luhvd', 'tti', 'tv__2d27f7', 'bnp', 'mdpos', 'ie5', 'nw6klf');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('Q', 'Sky Radio', 'a9000t5c4eci', 'gce376nium52', 'tv__2d27f7', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('O', 'tv__b2276b', 'l7', 'klex14ji', 'tv__2d27f7', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('@', NULL, 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', 'ph2', 'nd');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('D', 'tv__b2276b', 'wnqcx', '5hncprjtu0d', NULL, '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_7', '6ah', 'f8jswwl', '7xb72', 'O', 'xa', '7ryfdrz16n', 'jja', '5dh');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_8', 'ogrgjd8y', 't1afgog', 'itsj3', 'A', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_9', 'f', '5w1of7', 'pzo72ctdc', '_', 'mfg62', '0v', 'q8qdjpe1', 'o22');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_10', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', 'A', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "content" FROM "tv_channel" WHERE ("series_name" <> 'Sky Radio') ORDER BY content, "content" NULLS LAST;

/*
Gold Result:
(None,)
('A',)
('O',)
('_',)
('tv__2d27f7',)
*/

-- Prediction Query
SELECT Content FROM TV_Channel WHERE series_name = 'Sky Radio';

/*
Prediction Result:
('tv__2d27f7',)
*/