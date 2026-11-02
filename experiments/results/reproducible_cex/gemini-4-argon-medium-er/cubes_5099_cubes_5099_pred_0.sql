-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'A', 50, 'T1', '2000');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (2, 'B', 50, 'T2', '2001');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT famous_release_date FROM (SELECT LHS.artist_id AS artist_id, LHS.artist AS artist, LHS.age AS age, LHS.famous_title AS famous_title, LHS.famous_release_date AS famous_release_date, LHS.maxage AS maxage, RHS.artist_id AS artist_id_other, RHS.artist AS artist_other, RHS.age AS age_other, RHS.famous_release_date AS famous_release_date_other FROM (SELECT artist_id, artist, age, famous_title, famous_release_date, MAX(age) OVER () AS maxage FROM artist) AS LHS INNER JOIN (SELECT artist_id, artist, age, famous_title, famous_release_date, MAX(age) OVER () AS maxage FROM artist) AS RHS ON (LHS.age = RHS.maxage AND LHS.famous_title = RHS.famous_title)) ORDER BY famous_release_date;

/*
Gold Result:
('2000',)
('2001',)
*/

-- Prediction Query
SELECT Famous_Release_date FROM artist ORDER BY Age DESC, artist.artist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('2000',)
*/