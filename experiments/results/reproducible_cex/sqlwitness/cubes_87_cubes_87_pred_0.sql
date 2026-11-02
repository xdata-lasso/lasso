-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO tv_channel (id, series_name, country, language, content, pixel_aspect_ratio_par, hight_definition_tv, pay_per_view_ppv, package_option) VALUES ('default1', NULL, NULL, NULL, 'default1', NULL, 'default1', 'default2', 'default2'), ('default2', 'default2', NULL, 'default1', 'default1', NULL, 'default1', 'default2', NULL), ('unique_2', 'default1', NULL, 'default1', 'default2', 'default1', 'default2', NULL, 'default1');
INSERT INTO tv_series (id, channel, episode, air_date, rating, share, "18_49_rating_share", viewers_m, weekly_rank) VALUES (0.0, NULL, 'default1', 'default1', 'default2', 1.0, NULL, NULL, NULL), (1.0, 'default2', 'default1', 'default2', 'default2', NULL, 'default2', NULL, 1.0), (20000.0, 'unique_2', 'default2', NULL, 'default2', 0.0, 'default2', 'default1', 0.0), (40000.0, 'default2', 'default2', 'default2', 'default1', 1.0, 'default1', NULL, 1.0), (60000.0, NULL, 'default2', NULL, 'default2', 1.0, 'default2', 'default1', 1.0), (80000.0, 'unique_2', 'default2', 'default1', NULL, 1.0, 'default1', NULL, 0.0), (100000.0, 'default1', 'default1', 'default2', NULL, 0.0, 'default1', 'default1', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT episode FROM tv_series ORDER BY episode, tv_series.id NULLS LAST;

/*
Gold Result:
('default1',)
('default1',)
('default1',)
('default2',)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Episode FROM TV_series ORDER BY rating, TV_series.id NULLS LAST;

/*
Prediction Result:
('default2',)
('default1',)
('default2',)
('default1',)
('default1',)
('default2',)
('default2',)
*/