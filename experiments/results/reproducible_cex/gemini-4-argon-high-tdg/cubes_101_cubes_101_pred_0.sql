-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('700', 'Cartoon Network', 'United States', 'English', 'Animation', '16:9', 'yes', 'no', 'Basic');
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('701', 'Boomerang', 'United States', 'English', 'Classics', '4:3', 'no', 'no', 'Standard');
INSERT INTO "TV_series" ("id", "Channel", "Episode", "Air_Date", "Rating", "Share", "18_49_Rating_Share", "Viewers_m", "Weekly_Rank") VALUES (1.0, '700', 'Pilot Episode', '2010-11-26', 'TV-PG', 4.5, '1.2/4', '2.5', 15.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (1.0, '700', 'Young Justice', 'Brandon Vietti', 'Greg Weisman', '2010-11-26', 101.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (2.0, '700', 'Batman: The Brave and the Bold', 'Ben Jones', 'Michael Jelenic', '2008-11-14', 102.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (3.0, '701', 'Batman: The Brave and the Bold', 'Brandon Vietti', 'Paul Dini', '2009-01-09', 103.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (4.0, '701', 'Justice League', 'Lauren Montgomery', 'Dwayne McDuffie', '2001-11-17', 104.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (5.0, '700', 'Mystery Show', NULL, 'Greg Weisman', '2011-05-01', 105.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "cartoon" WHERE ("directed_by" = 'Brandon Vietti' OR "directed_by" = 'Ben Jones') ORDER BY title, cartoon.id NULLS LAST;

/*
Gold Result:
('Batman: The Brave and the Bold',)
('Batman: The Brave and the Bold',)
('Young Justice',)
*/

-- Prediction Query
SELECT Title FROM Cartoon WHERE Directed_by = 'Ben Jones' OR Directed_by = 'Brandon Vietti';

/*
Prediction Result:
('Young Justice',)
('Batman: The Brave and the Bold',)
('Batman: The Brave and the Bold',)
*/