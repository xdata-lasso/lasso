-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('c1', 'Canal Uno', 'Spain', 'Spanish', 'General', '16:9', 'yes', 'no', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('c2', 'TV Monde', 'France', 'French', 'Culture', '16:9', 'yes', 'no', 'Standard');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('c3', 'Silent TV', 'UK', NULL, 'Movies', '4:3', 'no', 'yes', 'None');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (1.0, 'c1', 'Pilot', '2021-03-15', '4.0', 10.0, '1.5/5', '4.2', 25.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (1.0, 'c2', 'Le Chat', 'Jean', 'Pierre', '2018-11-20', 201.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS "count___" FROM "tv_channel" WHERE ("language" = 'English') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM TV_Channel WHERE LANGUAGE = 'English';

/*
Prediction Result:
(0,)
*/