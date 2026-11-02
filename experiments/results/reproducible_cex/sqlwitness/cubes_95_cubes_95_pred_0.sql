-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO tv_channel (id, series_name, country, language, content, pixel_aspect_ratio_par, hight_definition_tv, pay_per_view_ppv, package_option) VALUES ('default1', 'default2', NULL, 'default2', 'default2', 'default1', 'English', 'English', 'default2'), ('English', NULL, 'default2', NULL, 'default1', NULL, 'default1', 'default2', NULL), ('default2', 'default1', NULL, NULL, 'English', NULL, NULL, 'default1', 'default1'), ('unique_3', NULL, 'default2', 'English', NULL, NULL, 'default1', 'English', NULL), ('unique_4', 'default1', 'default1', 'default1', 'default1', 'default1', NULL, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" AS "pixel_aspect_ratio_par", "pixel_aspect_ratio_par" AS "country" FROM "tv_channel" WHERE ("language" <> 'English') ORDER BY pixel_aspect_ratio_par, tv_channel.id NULLS LAST;

/*
Gold Result:
(None, 'default1')
('default1', 'default1')
*/

-- Prediction Query
SELECT Pixel_aspect_ratio_PAR, country FROM tv_channel WHERE LANGUAGE <> 'English';

/*
Prediction Result:
('default1', None)
('default1', 'default1')
*/