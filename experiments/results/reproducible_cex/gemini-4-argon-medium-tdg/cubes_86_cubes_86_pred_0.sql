-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('CH1', 'Comedy', 'UK', 'English', 'Laughs', '4:3', 'No', 'No', 'Standard');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (3.0, 'CH1', 'Ep_Tie_3', '2023-02-01', '8.1', 20.0, '2.0', '4.0', 2.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (1.0, 'CH1', 'Ep_Tie_1', '2023-02-02', '8.2', 20.0, '2.1', '4.1', 3.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (4.0, 'CH1', 'Ep_Tie_4', '2023-02-03', '8.3', 20.0, '2.2', '4.2', 1.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (2.0, 'CH1', 'Ep_Tie_2', '2023-02-04', '8.4', 20.0, '2.3', '4.3', 4.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (NULL, 'CH1', 'Ep_Tie_Null', '2023-02-05', '8.5', 20.0, '2.4', '4.4', 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT episode, rating FROM (SELECT * FROM (SELECT * FROM tv_series ORDER BY SHARE DESC, tv_series.id NULLS LAST) LIMIT 3);

/*
Gold Result:
('Ep_Tie_1', '8.2')
('Ep_Tie_2', '8.4')
('Ep_Tie_3', '8.1')
*/

-- Prediction Query
SELECT Episode, Rating FROM TV_series ORDER BY Rating DESC, TV_series.id NULLS LAST LIMIT 3;

/*
Prediction Result:
('Ep_Tie_Null', '8.5')
('Ep_Tie_2', '8.4')
('Ep_Tie_4', '8.3')
*/