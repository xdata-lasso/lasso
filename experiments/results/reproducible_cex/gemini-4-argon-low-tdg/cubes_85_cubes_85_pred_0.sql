-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join equality, WHERE filtering, column vs alias confusion, and ordering.
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('1', 'Series_X', 'USA', 'English', 'News', '16:9', 'Yes', 'No', 'Pkg_A');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('2', 'Series_Y', 'UK', 'English', 'Sports', '4:3', 'Yes', 'Yes', 'Pkg_B');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('3', 'Series_Z', 'Canada', 'French', 'Music', '21:9', 'No', 'No', 'Pkg_C');
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
*/