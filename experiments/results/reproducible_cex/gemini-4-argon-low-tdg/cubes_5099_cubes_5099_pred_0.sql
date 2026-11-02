-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Bowie', 80, 'Heroes', '1977-09-23');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (2, 'Eno', 50, 'Heroes', '1977-01-01');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (3, 'Iggy', 80, 'Lust for Life', '1975-08-29');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (4, 'Lou', 60, 'Transformer', '1972-11-08');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (1, 1, 'V1', '1977-10-01', 5.0, 'Heroes');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (1, 1, 'Grammy', '1978-02-23', 'Best Rock', 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT famous_release_date FROM (SELECT LHS.artist_id AS artist_id, LHS.artist AS artist, LHS.age AS age, LHS.famous_title AS famous_title, LHS.famous_release_date AS famous_release_date, LHS.maxage AS maxage, RHS.artist_id AS artist_id_other, RHS.artist AS artist_other, RHS.age AS age_other, RHS.famous_release_date AS famous_release_date_other FROM (SELECT artist_id, artist, age, famous_title, famous_release_date, MAX(age) OVER () AS maxage FROM artist) AS LHS INNER JOIN (SELECT artist_id, artist, age, famous_title, famous_release_date, MAX(age) OVER () AS maxage FROM artist) AS RHS ON (LHS.age = RHS.maxage AND LHS.famous_title = RHS.famous_title)) ORDER BY famous_release_date;

/*
Gold Result:
('1975-08-29',)
('1977-09-23',)
('1977-09-23',)
*/

-- Prediction Query
SELECT Famous_Release_date FROM artist ORDER BY Age DESC, artist.artist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('1977-09-23',)
*/