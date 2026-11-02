-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Arthur Pendelton', 60, 'Golden Hits', '1985-06-15');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (2, 'Bella Vance', 25, 'Golden Hits', '2018-03-20');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (3, 'Carlos Mendez', 40, 'Silver Echo', '2001-11-05');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (10, 2, 'Vol. 1', '2018-04-01', 4.5, 'Morning Light');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (20, 3, 'Vol. 2', '2001-12-01', 2.0, 'Echoes');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (100, 10, 'Summer Fest', '2018-08-10', 'Best Pop', 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT famous_release_date FROM (SELECT LHS.artist_id AS artist_id, LHS.artist AS artist, LHS.age AS age, LHS.famous_title AS famous_title, LHS.famous_release_date AS famous_release_date, LHS.maxage AS maxage, RHS.artist_id AS artist_id_other, RHS.artist AS artist_other, RHS.age AS age_other, RHS.famous_release_date AS famous_release_date_other FROM (SELECT artist_id, artist, age, famous_title, famous_release_date, MAX(age) OVER () AS maxage FROM artist) AS LHS INNER JOIN (SELECT artist_id, artist, age, famous_title, famous_release_date, MAX(age) OVER () AS maxage FROM artist) AS RHS ON (LHS.age = RHS.maxage AND LHS.famous_title = RHS.famous_title)) ORDER BY famous_release_date;

/*
Gold Result:
('1985-06-15',)
('1985-06-15',)
*/

-- Prediction Query
SELECT Famous_Release_date FROM artist ORDER BY Age DESC, artist.artist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('1985-06-15',)
*/