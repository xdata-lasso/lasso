-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'The Horizon', 29, 'Sunrise', '2018-05-10');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (1, 1, 'Vol. 10', '2020-01-01', 2.0, 'Zebra Crossing');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (2, 1, 'Vol. 11', '2020-02-01', 1.0, 'Middle Ground');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (3, 1, 'Vol. 12', '2020-03-01', 0.5, 'Halfway There');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (4, 1, 'Vol. 13', '2020-04-01', 1.2, 'Fractional Beat');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (5, 1, 'Vol. 14', '2020-05-01', 0.0, 'Zero Gravity');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (6, 1, 'Vol. 15', '2020-06-01', -1.0, 'Below Zero');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (7, 1, 'Vol. 16', '2020-07-01', NULL, 'Unknown Duration');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT song FROM volume WHERE (weeks_on_top <> 1.0) ORDER BY song, volume.volume_id NULLS LAST;

/*
Gold Result:
('Below Zero',)
('Fractional Beat',)
('Halfway There',)
('Zebra Crossing',)
('Zero Gravity',)
*/

-- Prediction Query
SELECT Song FROM volume WHERE Weeks_on_Top > 1;

/*
Prediction Result:
('Zebra Crossing',)
('Fractional Beat',)
*/