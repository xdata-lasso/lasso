-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('CH1', 'Toons Network', 'USA', 'English', 'Animation', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('CH2', 'Kids Zone', 'UK', 'English', 'Kids', '4:3', 'No', 'Yes', 'Premium');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('CH3', 'Anime Hub', 'Japan', 'Japanese', 'Anime', '16:9', 'Yes', 'No', 'Standard');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (101.0, 'CH2', 'Ep 1', '2020-01-01', 'PG', 4.5, '1.2/4', '2.5', 10.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (102.0, 'CH2', 'Ep 2', '2020-01-08', 'PG', 5.0, '1.5/5', '3.1', 8.0);
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (103.0, 'CH3', 'Ep 1', '2021-05-12', 'G', 3.2, '0.9/3', '1.8', 15.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (50.0, 'CH3', 'Avatar', 'Dave Filoni', 'Michael Dante', '2005-02-21', 101.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (20.0, 'CH1', 'Adventure Time', 'Larry Leichliter', 'Pendleton Ward', '2010-04-05', 10.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (5.0, 'CH1', 'Adventure Time', 'Pendleton Ward', 'Adam Muto', '2010-04-12', 30.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (10.0, 'CH2', 'Adventure Time', 'Bong Hee Han', 'Rebecca Sugar', '2010-04-19', 20.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (30.0, 'CH2', 'Batman', 'Bruce Timm', 'Paul Dini', '1992-09-05', 5.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (40.0, 'CH1', 'Batman', 'Bruce Timm', 'Alan Burnett', '1992-09-06', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, directed_by FROM cartoon ORDER BY title, cartoon.id NULLS LAST;

/*
Gold Result:
('Adventure Time', 'Pendleton Ward')
('Adventure Time', 'Bong Hee Han')
('Adventure Time', 'Larry Leichliter')
('Avatar', 'Dave Filoni')
('Batman', 'Bruce Timm')
('Batman', 'Bruce Timm')
*/

-- Prediction Query
SELECT title, Directed_by FROM Cartoon ORDER BY Original_air_date, Cartoon.id NULLS LAST;

/*
Prediction Result:
('Batman', 'Bruce Timm')
('Batman', 'Bruce Timm')
('Avatar', 'Dave Filoni')
('Adventure Time', 'Larry Leichliter')
('Adventure Time', 'Pendleton Ward')
('Adventure Time', 'Bong Hee Han')
*/