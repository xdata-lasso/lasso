-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('CH1', 'Series_X', 'USA', 'English', 'Drama', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('CH2', 'Series_Y', 'UK', 'English', 'Comedy', '4:3', 'No', 'Yes', 'Premium');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (1.0, 'CH1', 'Ep_C', '2020-01-03', '5.0', 12.0, '2.1/6', '8.5', 3.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (2.0, 'CH1', 'Ep_A', '2020-01-01', '6.0', 15.0, '2.5/7', '10.2', 1.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (3.0, 'CH2', 'Ep_B', '2020-01-02', '4.5', 10.0, '1.8/5', '7.0', 4.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (4.0, 'CH2', 'Ep_A', '2020-01-04', '5.5', 14.0, '2.3/6', '9.1', 2.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (1.0, 'CH1', 'Toon_1', 'Dir_A', 'Wri_A', '2019-05-01', 101.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT episode FROM tv_series ORDER BY episode, tv_series.id NULLS LAST;

/*
Gold Result:
('Ep_A',)
('Ep_A',)
('Ep_B',)
('Ep_C',)
*/

-- Prediction Query
SELECT Episode FROM TV_series ORDER BY rating, TV_series.id NULLS LAST;

/*
Prediction Result:
('Ep_B',)
('Ep_C',)
('Ep_A',)
('Ep_A',)
*/