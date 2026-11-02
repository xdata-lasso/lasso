-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC), duplicates (SELECT vs SELECT DISTINCT), NULLs in Episode, and extraneous INNER JOINs via NULL Channel.
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('C1', 'Series X', 'USA', 'English', 'Drama', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (1.0, 'C1', 'Ep_B', '2023-01-01', '8.5', 10.0, '2.1', '5.0', 1.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (2.0, NULL, 'Ep_A', '2023-01-02', '9.0', 12.0, '2.5', '6.0', 2.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (3.0, 'C1', 'Ep_A', '2023-01-03', '7.5', 8.0, '1.8', '4.0', 3.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (4.0, 'C1', NULL, '2023-01-04', '6.0', 5.0, '1.0', '2.0', 4.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT episode FROM tv_series ORDER BY episode, tv_series.id NULLS LAST;

/*
Gold Result:
(None,)
('Ep_A',)
('Ep_A',)
('Ep_B',)
*/

-- Prediction Query
SELECT Episode FROM TV_series ORDER BY rating, TV_series.id NULLS LAST;

/*
Prediction Result:
(None,)
('Ep_A',)
('Ep_B',)
('Ep_A',)
*/