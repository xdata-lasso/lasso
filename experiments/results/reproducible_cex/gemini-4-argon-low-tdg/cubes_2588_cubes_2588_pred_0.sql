-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Artist A', 25, 'Title 1', '2000');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (2, 'Artist B', 30, 'Title 2', '2005');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (3, 'Artist C', 35, 'Title 3', '2010');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (10, 3, 'Issue 10', '2020-01-01', 10.5, 'Song_MaxArtist_MinVol');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (20, 1, 'Issue 20', '2020-02-01', 2.0, 'Song_MinArtist_MidVol');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (30, 1, 'Issue 30', '2020-03-01', 8.0, 'Song_MinArtist_MaxVol');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (40, 2, 'Issue 40', '2020-04-01', 1.0, 'Song_MidArtist');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (1, 30, 'Fest A', '2021', 'Pop', 'Win');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT song FROM (SELECT * FROM (SELECT * FROM volume ORDER BY artist_id, volume.volume_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Song_MinArtist_MidVol',)
*/

-- Prediction Query
SELECT Song FROM volume ORDER BY Weeks_on_Top DESC, volume.volume_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Song_MaxArtist_MinVol',)
*/