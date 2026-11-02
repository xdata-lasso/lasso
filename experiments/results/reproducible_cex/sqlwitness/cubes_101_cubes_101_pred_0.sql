-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO tv_channel (id, series_name, country, language, content, pixel_aspect_ratio_par, hight_definition_tv, pay_per_view_ppv, package_option) VALUES ('Ben Jones', NULL, 'default1', 'Ben Jones', 'Ben Jones', 'default1', 'default2', 'default2', 'Ben Jones');
INSERT INTO cartoon (id, channel, title, directed_by, written_by, original_air_date, production_code) VALUES (1.0, 'Ben Jones', 'default1', 'Ben Jones', NULL, NULL, NULL), (0.0, NULL, 'Ben Jones', 'Ben Jones', NULL, NULL, NULL), (100000.0, 'Ben Jones', 'default1', 'default1', 'Ben Jones', 'default2', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "cartoon" WHERE ("directed_by" = 'Brandon Vietti' OR "directed_by" = 'Ben Jones') ORDER BY title, cartoon.id NULLS LAST;

/*
Gold Result:
('Ben Jones',)
('default1',)
*/

-- Prediction Query
SELECT Title FROM Cartoon WHERE Directed_by = 'Ben Jones' OR Directed_by = 'Brandon Vietti';

/*
Prediction Result:
('default1',)
('Ben Jones',)
*/