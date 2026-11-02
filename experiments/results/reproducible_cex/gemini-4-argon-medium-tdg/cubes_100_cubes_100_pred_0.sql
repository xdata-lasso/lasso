-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Title, tie-breaking by Cartoon.id (including NULLS LAST), and DISTINCT vs ALL with exact duplicates.
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('CH1', 'Series A', 'USA', 'English', 'Cartoons', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (3.0, 'CH1', 'Alpha', 'Director Z', 'Writer 1', '2020-01-01', 101.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (1.0, 'CH1', 'Alpha', 'Director A', 'Writer 2', '2020-01-02', 102.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (2.0, 'CH1', 'Alpha', 'Director A', 'Writer 3', '2020-01-03', 103.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (NULL, 'CH1', 'Alpha', 'Director M', 'Writer 4', '2020-01-04', 104.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (0.5, 'CH1', 'Beta', 'Director B', 'Writer 5', '2020-01-05', 105.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, directed_by FROM cartoon ORDER BY title, cartoon.id NULLS LAST;

/*
Gold Result:
('Alpha', 'Director A')
('Alpha', 'Director A')
('Alpha', 'Director Z')
('Alpha', 'Director M')
('Beta', 'Director B')
*/

-- Prediction Query
SELECT title, Directed_by FROM Cartoon ORDER BY Original_air_date, Cartoon.id NULLS LAST;

/*
Prediction Result:
('Alpha', 'Director Z')
('Alpha', 'Director A')
('Alpha', 'Director A')
('Alpha', 'Director M')
('Beta', 'Director B')
*/