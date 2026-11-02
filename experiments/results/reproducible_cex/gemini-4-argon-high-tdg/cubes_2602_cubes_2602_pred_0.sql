-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Adele', 30, '21', '2011-01-24');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (2, 'Ed Sheeran', 28, 'Divide', '2017-03-03');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (1, 1, 'Vol 1', '2011-02-10', 12.0, 'Rolling in the Deep');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (2, 2, 'Vol 2', '2017-04-01', 14.5, 'Shape of You');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (1, 1, 'Grammy Awards', '2020-05-10', 'Best Song', 'Awarded');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (2, 1, 'Brit Awards', '2019-01-01', 'Best Song', 'Nominated');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (3, 2, 'Billboard Music Awards', '2018-03-15', 'Best Artist', 'Awarded');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (4, 2, 'MTV Music Awards', '2017-07-20', 'Best Artist', 'Nominated');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (5, 1, 'American Music Awards', '2015-11-11', 'Best Song', 'Awarded');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (6, 2, 'World Music Awards', '2020-05-10', 'Best Song', 'Awarded');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_ceremony" FROM "music_festival" WHERE ("category" = 'Best Song' AND "result" = 'Awarded') ORDER BY date_of_ceremony, music_festival.id NULLS LAST;

/*
Gold Result:
('2015-11-11',)
('2020-05-10',)
('2020-05-10',)
*/

-- Prediction Query
SELECT Date_of_ceremony FROM music_festival WHERE Category = 'Best Song' AND RESULT = 'Awarded';

/*
Prediction Result:
('2020-05-10',)
('2015-11-11',)
('2020-05-10',)
*/