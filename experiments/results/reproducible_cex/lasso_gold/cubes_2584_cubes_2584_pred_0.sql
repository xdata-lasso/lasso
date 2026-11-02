-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT maxweeks_on_top AS max_weeks_on_top_, MIN(weeks_on_top) OVER () AS min_weeks_on_top_ FROM (SELECT volume_id, volume_issue, issue_date, weeks_on_top, song, artist_id, MAX(weeks_on_top) OVER () AS maxweeks_on_top FROM volume) ORDER BY max_weeks_on_top_, min_weeks_on_top_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(Weeks_on_Top), MIN(Weeks_on_Top) FROM volume;

/*
Prediction Result:
(None, None)
*/