-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('C1', 'Zeta', 'USA', 'English', 'News', '4:3', 'yes', 'no', 'Basic');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('C2', 'Alpha', 'UK', 'English', 'Sports', '16:9', 'yes', 'yes', 'Premium');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('C3', 'Beta', 'USA', 'Spanish', 'Music', '21:9', 'no', 'no', 'Standard');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('C4', 'Gamma', 'Canada', 'French', 'Drama', '1:1', NULL, 'no', 'Basic');
INSERT INTO TV_series (id, Channel, Episode, Air_Date, Rating, Share, "18_49_Rating_Share", Viewers_m, Weekly_Rank) VALUES (1.0, 'C1', 'Ep1', '2020-01-01', '8.5', 12.0, '2.1/6', '5.4', 1.0);
INSERT INTO Cartoon (id, Channel, Title, Directed_by, Written_by, Original_air_date, Production_code) VALUES (10.0, 'C1', 'Toon1', 'DirA', 'WriA', '2020-02-01', 101.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT pixel_aspect_ratio_par AS package_option, pixel_aspect_ratio_par_other AS series_name FROM (SELECT LHS.id AS id, LHS.series_name AS series_name, LHS.country AS country, LHS.language AS LANGUAGE, LHS.content AS content, LHS.pixel_aspect_ratio_par AS pixel_aspect_ratio_par, LHS.hight_definition_tv AS hight_definition_tv, LHS.pay_per_view_ppv AS pay_per_view_ppv, LHS.package_option AS package_option, RHS.id AS id_other, RHS.series_name AS series_name_other, RHS.country AS country_other, RHS.language AS language_other, RHS.content AS content_other, RHS.pixel_aspect_ratio_par AS pixel_aspect_ratio_par_other, RHS.hight_definition_tv AS hight_definition_tv_other, RHS.pay_per_view_ppv AS pay_per_view_ppv_other, RHS.package_option AS package_option_other FROM tv_channel AS LHS CROSS JOIN tv_channel AS RHS) WHERE (hight_definition_tv = hight_definition_tv_other) ORDER BY package_option, series_name NULLS LAST;

/*
Gold Result:
('16:9', '16:9')
('16:9', '4:3')
('21:9', '21:9')
('4:3', '16:9')
('4:3', '4:3')
*/

-- Prediction Query
SELECT package_option, series_name FROM TV_Channel WHERE hight_definition_TV = 'yes';

/*
Prediction Result:
('Basic', 'Zeta')
('Premium', 'Alpha')
*/