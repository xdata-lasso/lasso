-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cartoon (id, channel, title, directed_by, written_by, original_air_date, production_code) VALUES (1.0, NULL, 'default1', 'default2', NULL, 'default2', NULL), (0.0, NULL, 'default2', 'default2', NULL, NULL, 0.0), (33333.333333, NULL, 'default2', 'default2', 'default1', 'default2', 1.0), (66666.666667, NULL, 'default2', 'default1', NULL, 'default2', 1.0), (100000.0, NULL, 'default2', NULL, NULL, 'default2', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, directed_by FROM cartoon ORDER BY title, cartoon.id NULLS LAST;

/*
Gold Result:
('default1', 'default2')
('default2', 'default2')
('default2', 'default2')
('default2', 'default1')
('default2', None)
*/

-- Prediction Query
SELECT title, Directed_by FROM Cartoon ORDER BY Original_air_date, Cartoon.id NULLS LAST;

/*
Prediction Result:
('default2', 'default2')
('default1', 'default2')
('default2', 'default2')
('default2', 'default1')
('default2', None)
*/