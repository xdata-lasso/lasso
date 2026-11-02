-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('ch1', 'Alpha TV', 'UK', 'English', 'Sports', '16:9', 'yes', 'no', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('ch2', 'Beta TV', 'USA', 'English', 'Sports', '16:9', 'yes', 'no', 'Premium');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('ch3', 'Zeta Network', 'Canada', 'French', 'Music', '4:3', 'no', 'no', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('ch4', 'Sky Radio', 'Netherlands', 'Dutch', 'News', '16:9', 'no', 'yes', 'None');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (1.0, 'ch1', 'Ep 1', '2020-01-01', '5.0', 10.5, '2.1', '3.5', 1.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (2.0, 'ch1', 'Ep 2', '2020-01-08', '4.8', 9.0, '1.9', '3.1', 2.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (3.0, 'ch4', 'Ep 3', '2020-01-15', '3.2', 6.0, '1.1', '1.8', 5.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (10.0, 'ch1', 'Toon A', 'Dir A', 'Wri A', '2019-05-01', 101.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (20.0, 'ch4', 'Toon B', 'Dir B', 'Wri B', '2019-06-01', 102.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "content" FROM "tv_channel" WHERE ("series_name" <> 'Sky Radio') ORDER BY content, "content" NULLS LAST;

/*
Gold Result:
('Music',)
('Sports',)
*/

-- Prediction Query
SELECT Content FROM TV_Channel WHERE series_name = 'Sky Radio';

/*
Prediction Result:
('News',)
*/