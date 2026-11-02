-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO tv_channel (id, series_name, country, language, content, pixel_aspect_ratio_par, hight_definition_tv, pay_per_view_ppv, package_option) VALUES ('default2', 'Ben Jones', 'default1', 'default2', 'Ben Jones', 'default2', 'default2', 'default1', NULL), ('default1', NULL, NULL, 'default2', 'default1', 'default2', 'default2', 'default2', 'default2'), ('Ben Jones', 'Ben Jones', 'default2', NULL, 'default2', 'default1', NULL, 'default1', 'default2');
INSERT INTO cartoon (id, channel, title, directed_by, written_by, original_air_date, production_code) VALUES (1.0, 'default1', NULL, NULL, 'default2', 'default2', 1.0), (0.0, NULL, NULL, NULL, 'Ben Jones', 'default2', NULL), (16666.666667, 'default1', 'default1', 'Ben Jones', 'default1', 'default2', 1.0), (33333.333333, 'default1', 'Ben Jones', 'Ben Jones', 'default1', 'default2', NULL), (50000.0, 'Ben Jones', 'default2', 'default2', NULL, 'default2', 1.0), (66666.666667, 'Ben Jones', 'Ben Jones', 'Ben Jones', 'Ben Jones', 'default1', 0.0), (83333.333333, 'default2', NULL, NULL, 'default2', 'Ben Jones', 0.0), (100000.0, 'default1', NULL, 'default2', 'default2', 'Ben Jones', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "cartoon" WHERE ("directed_by" = 'Ben Jones') ORDER BY title, cartoon.id NULLS LAST;

/*
Gold Result:
('Ben Jones',)
('Ben Jones',)
('default1',)
*/

-- Prediction Query
SELECT Title FROM Cartoon WHERE Directed_by = 'Ben Jones';

/*
Prediction Result:
('default1',)
('Ben Jones',)
('Ben Jones',)
*/