-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: tv_channel --
INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_1', '5k5swwqcgs', '9n8', '4', 'gu7v', 'tv__c58277', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('tv__d2daf6', 'tti', 'tv__b686c1', 'tv__1226b3', 'bnp', 'tv__cfe618', 'mdpos', 'ie5', 'nw6klf');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('A', 'a9000t5c4eci', 'tv__20a229', 'gce376nium52', 'zbuo4nrqrof', 'tv__c58277', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('C', 'l7', 'tv__20a229', 'klex14ji', '7zwau2dwyr', 'tv__c58277', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('tv__7c7e67', 'rkf9vqx5', 'tv__54aa77', 'tv__c0c8b0', 'pz0f8jegd', 'tv__9dd02f', '1vy9uxj4', 'wb', 'v');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_6', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', 'tv__c58277', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('id_7', 'kn6vc', NULL, '6ah', 'f8jswwl', 'tv__c58277', '7xb72', 'xa', '7ryfdrz16n');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('@', 'jja', '5dh', 'English', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430');

INSERT INTO "tv_channel" ("id", "series_name", "country", "language", "content", "pixel_aspect_ratio_par", "hight_definition_tv", "pay_per_view_ppv", "package_option") VALUES ('!', 'jh3den8', 'c68x8vacx7', NULL, 'f', '5w1of7', 'pzo72ctdc', 'mfg62', '0v');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" AS "pixel_aspect_ratio_par", "pixel_aspect_ratio_par" AS "country" FROM "tv_channel" WHERE ("language" <> 'English') ORDER BY pixel_aspect_ratio_par, tv_channel.id NULLS LAST;

/*
Gold Result:
(None, 'tv__c58277')
('9n8', 'tv__c58277')
('nd', 'tv__c58277')
('tv__20a229', 'tv__c58277')
('tv__20a229', 'tv__c58277')
('tv__54aa77', 'tv__9dd02f')
('tv__b686c1', 'tv__cfe618')
*/

-- Prediction Query
SELECT Pixel_aspect_ratio_PAR, country FROM tv_channel WHERE LANGUAGE <> 'English';

/*
Prediction Result:
('tv__c58277', '9n8')
('tv__cfe618', 'tv__b686c1')
('tv__c58277', 'tv__20a229')
('tv__c58277', 'tv__20a229')
('tv__9dd02f', 'tv__54aa77')
('tv__c58277', 'nd')
('tv__c58277', None)
*/