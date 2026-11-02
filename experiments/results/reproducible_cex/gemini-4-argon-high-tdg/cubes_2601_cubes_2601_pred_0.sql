-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Adele', 32, '21', '2011-01-24');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (2, 'Coldplay', 43, 'Parachutes', '2000-07-10');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (3, 'Unreferenced Artist', 29, 'None', '1999-01-01');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (10, 1, '45:14', '2011-02-01', 12.0, 'Rolling in the Deep');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (20, 2, '46:02', '2000-08-01', 4.5, 'Yellow');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (30, 1, '47:09', '2012-03-15', 8.0, 'Someone Like You');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (40, 2, '48:00', '2015-05-05', 1.0, 'Unreferenced Song');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (1, 10, 'Brit Awards', '2012-02-21', 'Best British Single', 'Nominated');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (2, 30, 'Grammy Awards', '2011-02-13', 'Record of the Year', 'Won');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (3, 20, 'MTV Awards', '2011-02-13', 'Best Rock Video', 'Awarded');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (4, 20, 'Mercury Prize', '2010-09-07', 'Album of the Year', 'Lost');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_ceremony, RESULT FROM music_festival ORDER BY date_of_ceremony, music_festival.id NULLS LAST;

/*
Gold Result:
('2010-09-07', 'Lost')
('2011-02-13', 'Won')
('2011-02-13', 'Awarded')
('2012-02-21', 'Nominated')
*/

-- Prediction Query
SELECT Date_of_ceremony, RESULT FROM music_festival;

/*
Prediction Result:
('2012-02-21', 'Nominated')
('2011-02-13', 'Won')
('2011-02-13', 'Awarded')
('2010-09-07', 'Lost')
*/