-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO TV_Channel (id, Country) VALUES ('1', NULL);
INSERT INTO TV_Channel (id, Country) VALUES ('2', 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country, n AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT country, COUNT(*) AS n FROM tv_channel GROUP BY country) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None, 1)
*/

-- Prediction Query
SELECT Country, COUNT(*) FROM TV_Channel GROUP BY Country ORDER BY COUNT(*) DESC, Country NULLS LAST LIMIT 1;

/*
Prediction Result:
('USA', 1)
*/