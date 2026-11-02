-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'Artist A', 25, 'Title A', '2020-01-01');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (2, 1, 'Issue 1', '2020-01-01', 10.0, 'Song A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT song FROM (SELECT volume_id, volume_issue, issue_date, weeks_on_top, song, volume_id AS artist_id, maxweeks_on_top, volume_id_other, volume_issue_other, issue_date_other, song_other, maxweeks_on_top_other FROM (SELECT LHS.volume_id AS volume_id, LHS.volume_issue AS volume_issue, LHS.issue_date AS issue_date, LHS.weeks_on_top AS weeks_on_top, LHS.song AS song, LHS.artist_id AS artist_id, LHS.maxweeks_on_top AS maxweeks_on_top, RHS.volume_id AS volume_id_other, RHS.volume_issue AS volume_issue_other, RHS.issue_date AS issue_date_other, RHS.song AS song_other, RHS.maxweeks_on_top AS maxweeks_on_top_other FROM (SELECT volume_id, volume_issue, issue_date, weeks_on_top, song, artist_id, MAX(weeks_on_top) OVER () AS maxweeks_on_top FROM volume) AS LHS INNER JOIN (SELECT volume_id, volume_issue, issue_date, weeks_on_top, song, artist_id, MAX(weeks_on_top) OVER () AS maxweeks_on_top FROM volume) AS RHS ON (LHS.volume_id = RHS.artist_id AND LHS.maxweeks_on_top = RHS.weeks_on_top))) ORDER BY song;

/*
Gold Result:
*/

-- Prediction Query
SELECT Song FROM volume ORDER BY Weeks_on_Top DESC, volume.volume_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Song A',)
*/