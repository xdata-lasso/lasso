-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering, duplicate preservation (SELECT vs SELECT DISTINCT), NULL handling in WHERE, and NULLS in Weekly_Rank.
INSERT INTO "TV_Channel" ("id", "series_name") VALUES ('C1', 'Drama Network');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Weekly_Rank") VALUES (10.0, 'C1', 'A Love of a Lifetime', 5.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Weekly_Rank") VALUES (20.0, 'C1', 'A Love of a Lifetime', 1.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Weekly_Rank") VALUES (30.0, 'C1', 'A Love of a Lifetime', 5.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Weekly_Rank") VALUES (40.0, 'C1', 'A Love of a Lifetime', NULL);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Weekly_Rank") VALUES (50.0, 'C1', 'Another Episode', 2.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Weekly_Rank") VALUES (60.0, 'C1', NULL, 3.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "weekly_rank" FROM "tv_series" WHERE ("episode" = 'A Love of a Lifetime') ORDER BY weekly_rank, tv_series.id NULLS LAST;

/*
Gold Result:
(None,)
(1.0,)
(5.0,)
(5.0,)
*/

-- Prediction Query
SELECT Weekly_Rank FROM TV_series WHERE Episode = 'A Love of a Lifetime';

/*
Prediction Result:
(5.0,)
(1.0,)
(5.0,)
(None,)
*/