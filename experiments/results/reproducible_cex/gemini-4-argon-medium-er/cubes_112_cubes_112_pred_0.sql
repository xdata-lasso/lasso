-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "TV_Channel" ("id", "series_name") VALUES ('C1', 'Channel 1');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by") VALUES (1, 'C1', 'T1', 'A');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by") VALUES (2, 'C1', 'T2', 'A');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by") VALUES (3, 'C1', 'T3', 'B');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by") VALUES (4, 'C1', 'T4', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, directed_by FROM (SELECT directed_by, COUNT(*) AS n FROM cartoon GROUP BY directed_by) ORDER BY count___, directed_by NULLS LAST;

/*
Gold Result:
(1, 'B')
(1, None)
(2, 'A')
*/

-- Prediction Query
SELECT COUNT(*), Directed_by FROM cartoon GROUP BY Directed_by;

/*
Prediction Result:
(1, None)
(2, 'A')
(1, 'B')
*/