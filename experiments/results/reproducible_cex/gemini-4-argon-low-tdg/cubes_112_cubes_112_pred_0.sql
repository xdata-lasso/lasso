-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY, COUNT(*), primary ORDER BY count___ ASC, secondary ORDER BY directed_by ASC, and NULLS LAST handling.
-- Also tests mutants that incorrectly INNER JOIN with TV_Channel (by including NULL Channel) or count distinct non-key attributes.
INSERT INTO "TV_Channel" ("id", "series_name") VALUES ('CH1', 'Cartoon Network');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (1.0, 'CH1', 'Episode 1', 'Zack', 'Writer A', '2020-01-01', 101.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (2.0, NULL, 'Episode 1', 'Alice', 'Writer A', '2020-01-01', 101.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (3.0, 'CH1', 'Episode 2', NULL, 'Writer B', '2020-01-02', 102.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (4.0, 'CH1', 'Episode 3', 'Bob', NULL, '2020-01-03', 103.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (5.0, NULL, 'Episode 3', 'Bob', NULL, '2020-01-03', 103.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (6.0, 'CH1', 'Episode 4', 'Charlie', 'Writer C', '2020-01-04', 104.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (7.0, 'CH1', 'Episode 5', 'Charlie', 'Writer C', '2020-01-05', 105.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (8.0, 'CH1', 'Episode 6', 'Charlie', 'Writer C', '2020-01-06', 106.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, directed_by FROM (SELECT directed_by, COUNT(*) AS n FROM cartoon GROUP BY directed_by) ORDER BY count___, directed_by NULLS LAST;

/*
Gold Result:
(1, 'Alice')
(1, 'Zack')
(1, None)
(2, 'Bob')
(3, 'Charlie')
*/

-- Prediction Query
SELECT COUNT(*), Directed_by FROM cartoon GROUP BY Directed_by;

/*
Prediction Result:
(1, None)
(1, 'Alice')
(2, 'Bob')
(3, 'Charlie')
(1, 'Zack')
*/