-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('CH1', 'Series Alpha', 'USA', 'English', 'Drama', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('CH2', 'Series Beta', 'UK', 'English', 'Comedy', '4:3', 'No', 'Yes', 'Premium');
INSERT INTO TV_series (id, Channel, Episode, Air_Date, Rating, Share, "18_49_Rating_Share", Viewers_m, Weekly_Rank) VALUES (1.0, 'CH1', 'Ep_LowShare', '2020-01-01', '9.9', 4.2, '5.0/15', '15.2', 1.0);
INSERT INTO TV_series (id, Channel, Episode, Air_Date, Rating, Share, "18_49_Rating_Share", Viewers_m, Weekly_Rank) VALUES (2.0, 'CH1', 'Ep_Fourth', '2020-01-08', '8.8', 9.8, '4.0/12', '12.1', 2.0);
INSERT INTO TV_series (id, Channel, Episode, Air_Date, Rating, Share, "18_49_Rating_Share", Viewers_m, Weekly_Rank) VALUES (3.0, 'CH2', 'Ep_Third', '2020-01-15', '7.7', 12.3, '3.0/10', '9.5', 3.0);
INSERT INTO TV_series (id, Channel, Episode, Air_Date, Rating, Share, "18_49_Rating_Share", Viewers_m, Weekly_Rank) VALUES (4.0, 'CH2', 'Ep_Second', '2020-01-22', '6.6', 19.0, '2.0/8', '6.4', 4.0);
INSERT INTO TV_series (id, Channel, Episode, Air_Date, Rating, Share, "18_49_Rating_Share", Viewers_m, Weekly_Rank) VALUES (5.0, 'CH1', 'Ep_First', '2020-01-29', '5.5', 25.5, '1.0/5', '3.1', 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT episode, rating FROM (SELECT * FROM (SELECT * FROM tv_series ORDER BY SHARE DESC, tv_series.id NULLS LAST) LIMIT 3);

/*
Gold Result:
('Ep_First', '5.5')
('Ep_Second', '6.6')
('Ep_Third', '7.7')
*/

-- Prediction Query
SELECT Episode, Rating FROM TV_series ORDER BY Rating DESC, TV_series.id NULLS LAST LIMIT 3;

/*
Prediction Result:
('Ep_LowShare', '9.9')
('Ep_Fourth', '8.8')
('Ep_Third', '7.7')
*/