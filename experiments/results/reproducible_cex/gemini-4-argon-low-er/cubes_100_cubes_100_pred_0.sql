-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "TV_Channel" ("id", "series_name") VALUES ('C1', 'Series 1');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Original_air_date") VALUES (1.0, 'C1', 'B', 'Dir1', '2020-01-01');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Original_air_date") VALUES (2.0, 'C1', 'A', 'Dir2', '2020-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, directed_by FROM cartoon ORDER BY title, cartoon.id NULLS LAST;

/*
Gold Result:
('A', 'Dir2')
('B', 'Dir1')
*/

-- Prediction Query
SELECT title, Directed_by FROM Cartoon ORDER BY Original_air_date, Cartoon.id NULLS LAST;

/*
Prediction Result:
('B', 'Dir1')
('A', 'Dir2')
*/