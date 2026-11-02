-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO tv_channel (id, series_name, country, language, content, pixel_aspect_ratio_par, hight_definition_tv, pay_per_view_ppv, package_option) VALUES ('default1', 'default2', 'default1', 'default2', NULL, NULL, NULL, 'default2', 'default1');
INSERT INTO tv_series (id, channel, episode, air_date, rating, share, "18_49_rating_share", viewers_m, weekly_rank) VALUES (1.0, 'default1', 'default2', 'default1', NULL, 3.0, 'default2', NULL, 3.0), (3.0, NULL, 'default1', 'default2', 'default1', NULL, 'default2', 'default1', NULL), (0.0, 'default1', 'default1', 'default1', 'default1', 1.0, 'default2', 'default1', 3.0), (4.0, NULL, 'default2', 'default2', 'default2', NULL, 'default2', NULL, 3.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT episode, rating FROM (SELECT * FROM (SELECT * FROM tv_series ORDER BY SHARE DESC, tv_series.id NULLS LAST) LIMIT 3);

/*
Gold Result:
('default2', None)
('default1', 'default1')
('default1', 'default1')
*/

-- Prediction Query
SELECT Episode, Rating FROM TV_series ORDER BY Rating DESC, TV_series.id NULLS LAST LIMIT 3;

/*
Prediction Result:
('default2', 'default2')
('default1', 'default1')
('default1', 'default1')
*/