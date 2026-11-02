-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO tv_channel (id, series_name, country, language, content, pixel_aspect_ratio_par, hight_definition_tv, pay_per_view_ppv, package_option) VALUES ('default1', 'A Love of a Lifetime', 'default2', 'default2', 'default1', 'default2', 'default1', NULL, 'default1'), ('default2', 'A Love of a Lifetime', 'default1', 'default2', 'default1', NULL, 'default2', 'default2', 'default2'), ('A Love of a Lifetime', 'default2', 'default2', 'default1', 'default1', 'default1', NULL, 'A Love of a Lifetime', 'default2'), ('unique_3', 'A Love of a Lifetime', 'default2', 'default1', 'default2', 'default1', 'default2', 'default2', 'A Love of a Lifetime'), ('unique_4', 'default2', 'A Love of a Lifetime', 'default1', 'default1', 'A Love of a Lifetime', 'default1', 'default2', NULL), ('unique_5', 'default2', NULL, NULL, 'A Love of a Lifetime', 'default2', NULL, NULL, NULL), ('unique_6', 'A Love of a Lifetime', 'A Love of a Lifetime', 'default1', 'default1', NULL, 'default2', 'A Love of a Lifetime', 'default1'), ('unique_7', NULL, 'A Love of a Lifetime', 'default2', 'default1', 'default2', 'default1', 'default1', 'default1'), ('unique_8', 'A Love of a Lifetime', NULL, 'default2', 'A Love of a Lifetime', 'default2', NULL, 'default2', 'A Love of a Lifetime'), ('unique_9', 'default2', NULL, 'default1', NULL, 'A Love of a Lifetime', NULL, NULL, 'default1'), ('unique_10', NULL, 'default1', 'default1', 'A Love of a Lifetime', 'A Love of a Lifetime', 'default1', NULL, NULL), ('unique_11', NULL, 'default2', 'default2', 'default1', 'default1', 'default2', 'A Love of a Lifetime', 'default2'), ('unique_12', NULL, 'A Love of a Lifetime', NULL, NULL, NULL, 'default2', 'default2', 'default2'), ('unique_13', NULL, 'default2', 'default2', NULL, 'A Love of a Lifetime', 'default1', 'A Love of a Lifetime', 'default2'), ('unique_14', 'default1', 'default2', NULL, 'default2', 'default1', 'default1', NULL, 'default1');
INSERT INTO tv_series (id, channel, episode, air_date, rating, share, "18_49_rating_share", viewers_m, weekly_rank) VALUES (1.0, NULL, 'default2', 'A Love of a Lifetime', NULL, NULL, NULL, 'default2', 0.0), (0.0, 'A Love of a Lifetime', 'default1', 'default1', NULL, 1.0, 'default1', 'default1', 0.0), (9090.909091, 'unique_11', NULL, NULL, NULL, NULL, 'default2', 'default1', 0.0), (18181.818182, 'unique_12', 'A Love of a Lifetime', NULL, 'default2', 0.0, NULL, NULL, 1.0), (27272.727273, 'unique_5', 'default1', 'A Love of a Lifetime', 'A Love of a Lifetime', 0.0, NULL, 'default1', 1.0), (36363.636364, 'unique_6', NULL, 'A Love of a Lifetime', 'default2', NULL, 'default2', 'default1', 0.0), (45454.545455, 'unique_3', NULL, 'A Love of a Lifetime', 'A Love of a Lifetime', 1.0, NULL, NULL, 1.0), (54545.454545, 'A Love of a Lifetime', NULL, 'default1', 'default1', 1.0, 'default1', 'default1', 1.0), (63636.363636, 'default2', 'A Love of a Lifetime', 'default2', NULL, 1.0, NULL, 'default1', 0.0), (72727.272727, 'unique_11', 'default2', 'A Love of a Lifetime', 'default2', 0.0, 'default1', 'A Love of a Lifetime', NULL), (81818.181818, 'default1', 'A Love of a Lifetime', 'A Love of a Lifetime', 'default1', 0.0, 'default1', NULL, 1.0), (90909.090909, 'unique_5', NULL, 'default1', 'A Love of a Lifetime', 0.0, 'default1', 'A Love of a Lifetime', 1.0), (100000.0, 'unique_9', NULL, NULL, NULL, 1.0, NULL, 'default2', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "weekly_rank" FROM "tv_series" WHERE ("episode" = 'A Love of a Lifetime') ORDER BY weekly_rank, tv_series.id NULLS LAST;

/*
Gold Result:
(0.0,)
(1.0,)
(1.0,)
*/

-- Prediction Query
SELECT Weekly_Rank FROM TV_series WHERE Episode = 'A Love of a Lifetime';

/*
Prediction Result:
(1.0,)
(0.0,)
(1.0,)
*/