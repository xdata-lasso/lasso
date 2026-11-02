-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('CH1', 'Cartoon Network', 'USA', 'English', 'Animation', '16:9', 'Yes', 'No', 'Standard');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (10.0, 'CH1', 'Zebra Attack', 'Ben Jones', 'John Doe', '2010-01-01', 101.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (20.0, 'CH1', 'Alpha Strike', 'Ben Jones', 'Jane Doe', '2010-01-02', 102.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (5.0, 'CH1', 'Alpha Strike', 'Ben Jones', 'Jane Doe', '2010-01-03', 103.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (30.0, 'CH1', 'Beta Wave', 'Michael Chang', 'Ben Jones', '2010-01-04', 104.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (40.0, 'CH1', 'Gamma Ray', 'ben jones', 'John Doe', '2010-01-05', 105.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (50.0, 'CH1', 'Delta Force', 'Ben Jones Jr.', 'John Doe', '2010-01-06', 106.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (60.0, 'CH1', 'Omega End', NULL, 'Ben Jones', '2010-01-07', 107.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "cartoon" WHERE ("directed_by" = 'Ben Jones') ORDER BY title, cartoon.id NULLS LAST;

/*
Gold Result:
('Alpha Strike',)
('Alpha Strike',)
('Zebra Attack',)
*/

-- Prediction Query
SELECT Title FROM Cartoon WHERE Directed_by = 'Ben Jones';

/*
Prediction Result:
('Zebra Attack',)
('Alpha Strike',)
('Alpha Strike',)
*/