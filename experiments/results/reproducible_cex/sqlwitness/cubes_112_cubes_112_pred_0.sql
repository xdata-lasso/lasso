-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cartoon (id, channel, title, directed_by, written_by, original_air_date, production_code) VALUES (0.0, NULL, NULL, 'default2', NULL, 'default2', 1.0), (1.0, NULL, NULL, 'default1', 'default2', 'default1', NULL), (50000.0, NULL, NULL, 'default1', 'default2', NULL, 1.0), (100000.0, NULL, 'default1', 'default1', 'default2', NULL, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, directed_by FROM (SELECT directed_by, COUNT(*) AS n FROM cartoon GROUP BY directed_by) ORDER BY count___, directed_by NULLS LAST;

/*
Gold Result:
(1, 'default2')
(3, 'default1')
*/

-- Prediction Query
SELECT COUNT(*), Directed_by FROM cartoon GROUP BY Directed_by;

/*
Prediction Result:
(3, 'default1')
(1, 'default2')
*/