-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "TV_Channel" ("id") VALUES ('C1');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Rating", "Share") VALUES (1.0, 'C1', 'Ep1', '9.0', 10.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Rating", "Share") VALUES (2.0, 'C1', 'Ep2', '8.0', 20.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Rating", "Share") VALUES (3.0, 'C1', 'Ep3', '7.0', 30.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Rating", "Share") VALUES (4.0, 'C1', 'Ep4', '1.0', 40.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT episode, rating FROM (SELECT * FROM (SELECT * FROM tv_series ORDER BY SHARE DESC, tv_series.id NULLS LAST) LIMIT 3);

/*
Gold Result:
('Ep4', '1.0')
('Ep3', '7.0')
('Ep2', '8.0')
*/

-- Prediction Query
SELECT Episode, Rating FROM TV_series ORDER BY Rating DESC, TV_series.id NULLS LAST LIMIT 3;

/*
Prediction Result:
('Ep1', '9.0')
('Ep2', '8.0')
('Ep3', '7.0')
*/