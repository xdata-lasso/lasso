-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Artist A', 25, 'Title A', '2020-01-01');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (1, 1, 'Issue 1', '2020-02-01', 3.0, 'Song 1');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (2, 1, 'Issue 2', '2020-03-01', 2.0, 'Song 2');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (1, 1, 'Fest 1', '2021-01-01', 'Pop', 'Nominated');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (2, 2, 'Fest 1', '2021-01-01', 'Pop', 'Awarded');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (3, 1, 'Fest 2', '2021-02-01', 'Pop', 'Nominated');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (4, 1, 'Fest 3', '2021-03-01', 'Pop', 'Awarded');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (5, 1, 'Fest 1', '2021-01-01', 'Rock', 'Awarded');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (6, 2, 'Fest 1', '2021-01-01', 'Rock', 'Nominated');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (7, 1, 'Fest 1', '2021-01-01', 'Rock', 'Rejected');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (8, 2, 'Fest 2', '2021-02-01', 'Rock', 'Awarded');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, n AS count___ FROM (SELECT category, date_of_ceremony, COUNT(*) AS n FROM music_festival GROUP BY category, date_of_ceremony) ORDER BY category, count___ NULLS LAST;

/*
Gold Result:
('Pop', 1)
('Pop', 1)
('Pop', 2)
('Rock', 1)
('Rock', 3)
*/

-- Prediction Query
SELECT Category, COUNT(*) FROM music_festival GROUP BY Category;

/*
Prediction Result:
('Pop', 4)
('Rock', 4)
*/