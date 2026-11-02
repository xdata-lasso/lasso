-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('2', 'Series B', 'France', 'French', 'News', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('1', 'Series A', 'Spain', 'Spanish', 'Sports', '4:3', 'No', 'Yes', 'Premium');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" AS "pixel_aspect_ratio_par", "pixel_aspect_ratio_par" AS "country" FROM "tv_channel" WHERE ("language" <> 'English') ORDER BY pixel_aspect_ratio_par, tv_channel.id NULLS LAST;

/*
Gold Result:
('France', '16:9')
('Spain', '4:3')
*/

-- Prediction Query
SELECT Pixel_aspect_ratio_PAR, country FROM tv_channel WHERE LANGUAGE <> 'English';

/*
Prediction Result:
('16:9', 'France')
('4:3', 'Spain')
*/