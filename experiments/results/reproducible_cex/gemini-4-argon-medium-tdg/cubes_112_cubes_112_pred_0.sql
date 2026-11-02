-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('CH1', 'Nick', 'USA', 'English', 'Cartoons', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('CH2', 'CN', 'USA', 'English', 'Cartoons', '4:3', 'No', 'No', 'Premium');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (1.0, 'CH1', 'Ep 1', 'Charlie', 'Alice', '2020-01-01', 101.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (2.0, 'CH1', 'Ep 2', 'Alice', 'Bob', '2020-01-02', 102.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (3.0, 'CH2', 'Ep 3', 'Bob', 'Charlie', '2020-01-03', 103.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (4.0, 'CH1', 'Ep 4', 'Bob', 'Charlie', '2020-01-04', 103.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (5.0, 'CH2', 'Ep 5', 'Dave', 'Dave', '2020-01-05', 104.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (6.0, 'CH2', 'Ep 6', 'Dave', 'Eve', '2020-01-06', 105.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (7.0, 'CH1', 'Ep 7', 'Dave', 'Frank', '2020-01-07', 106.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, directed_by FROM (SELECT directed_by, COUNT(*) AS n FROM cartoon GROUP BY directed_by) ORDER BY count___, directed_by NULLS LAST;

/*
Gold Result:
(1, 'Alice')
(1, 'Charlie')
(2, 'Bob')
(3, 'Dave')
*/

-- Prediction Query
SELECT COUNT(*), Directed_by FROM cartoon GROUP BY Directed_by;

/*
Prediction Result:
(1, 'Alice')
(2, 'Bob')
(1, 'Charlie')
(3, 'Dave')
*/