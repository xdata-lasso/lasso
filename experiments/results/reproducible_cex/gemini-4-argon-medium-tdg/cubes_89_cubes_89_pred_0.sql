-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('C1', 'Channel One', 'USA', 'English', 'Cartoons', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (1.0, 'C1', 'Zebra Attack', 'Ben Jones', 'Jane Doe', '2020-01-01', 101.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (2.0, 'C1', 'Alpha Strike', 'Ben Jones', 'John Smith', '2020-01-02', 102.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (3.0, 'C1', 'Beta Wave', 'John Smith', 'Ben Jones', '2020-01-03', 103.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (4.0, 'C1', 'Ben Jones', 'Other Director', 'Writer X', '2020-01-04', 104.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (5.0, 'C1', 'Gamma Ray', NULL, 'Writer Y', '2020-01-05', 105.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "cartoon" WHERE ("directed_by" = 'Ben Jones') ORDER BY title, cartoon.id NULLS LAST;

/*
Gold Result:
('Alpha Strike',)
('Zebra Attack',)
*/

-- Prediction Query
SELECT Title FROM Cartoon WHERE Directed_by = 'Ben Jones';

/*
Prediction Result:
('Zebra Attack',)
('Alpha Strike',)
*/