-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Title, tie-breaking by Cartoon.id ASC, NULLS LAST on id, and DISTINCT vs ALL with duplicate (title, directed_by) pairs.
INSERT INTO "TV_Channel" ("id", "series_name", "Country", "Language", "Content", "Pixel_aspect_ratio_PAR", "Hight_definition_TV", "Pay_per_view_PPV", "Package_Option") VALUES ('CH1', 'Cartoon Network', 'USA', 'English', 'Cartoons', '16:9', 'Yes', 'No', 'Basic');
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (20.0, 'CH1', 'Avatar', 'Dave Filoni', 'Michael Dante DiMartino', '2005-02-21', 101.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (10.0, 'CH1', 'Avatar', 'Lauren MacMullan', 'Aaron Ehasz', '2005-02-25', 102.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (NULL, 'CH1', 'Avatar', 'Giancarlo Volpe', 'Tim Hedrick', '2005-03-04', 103.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (5.0, 'CH1', 'Ben 10', 'Scooter Tidwell', 'Duncan Rouleau', '2005-12-27', 201.0);
INSERT INTO "Cartoon" ("id", "Channel", "Title", "Directed_by", "Written_by", "Original_air_date", "Production_code") VALUES (15.0, 'CH1', 'Ben 10', 'Scooter Tidwell', 'Joe Casey', '2006-01-14', 202.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, directed_by FROM cartoon ORDER BY title, cartoon.id NULLS LAST;

/*
Gold Result:
('Avatar', 'Lauren MacMullan')
('Avatar', 'Dave Filoni')
('Avatar', 'Giancarlo Volpe')
('Ben 10', 'Scooter Tidwell')
('Ben 10', 'Scooter Tidwell')
*/

-- Prediction Query
SELECT title, Directed_by FROM Cartoon ORDER BY Original_air_date, Cartoon.id NULLS LAST;

/*
Prediction Result:
('Avatar', 'Dave Filoni')
('Avatar', 'Lauren MacMullan')
('Avatar', 'Giancarlo Volpe')
('Ben 10', 'Scooter Tidwell')
('Ben 10', 'Scooter Tidwell')
*/