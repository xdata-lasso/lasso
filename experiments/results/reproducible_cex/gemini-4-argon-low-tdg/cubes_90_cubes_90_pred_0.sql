-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inequality filter ('Sky Radio' vs others), DISTINCT elimination, column vs alias confusion in SELECT/ORDER BY, and extraneous JOINs with TV_series/Cartoon.
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('1', 'Sky Radio', 'UK', 'English', 'Music', '16:9', 'Yes', 'No', 'Pkg_Z');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('2', 'BBC One', 'UK', 'English', 'General', '4:3', 'No', 'No', 'Pkg_A');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('3', 'MTV', 'USA', 'English', 'Music', '4:3', 'Yes', 'Yes', 'Pkg_M');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('4', 'CNN', 'USA', 'English', 'News', '14:9', 'Yes', 'No', 'Pkg_X');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (101.0, '1', 'Ep 1', '2020-01-01', '5.0', 10.0, '2.0', '1.5', 1.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (201.0, '1', 'Toon 1', 'Dir A', 'Wri A', '2020-01-01', 1001.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "pixel_aspect_ratio_par" AS "package_option" FROM "tv_channel" WHERE ("series_name" <> 'Sky Radio') ORDER BY package_option;

/*
Gold Result:
('14:9',)
('4:3',)
*/

-- Prediction Query
SELECT Package_Option FROM TV_Channel WHERE series_name = 'Sky Radio';

/*
Prediction Result:
('Pkg_Z',)
*/