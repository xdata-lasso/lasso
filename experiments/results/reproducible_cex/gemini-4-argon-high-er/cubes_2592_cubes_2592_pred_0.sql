-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Gorgoroth', 30, 'Title A', '2000-01-01');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (1, 1, 'Issue 1', '2022-01-01', 1.0, 'Song A');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (2, 1, 'Issue 2', '2020-01-01', 2.0, 'Song B');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (3, 1, 'Issue 3', NULL, 3.0, 'Song C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "issue_date" FROM (SELECT "LHS"."artist_id" AS "artist_id", "LHS"."artist" AS "artist", "LHS"."age" AS "age", "LHS"."famous_title" AS "famous_title", "LHS"."famous_release_date" AS "famous_release_date", "RHS"."volume_id" AS "volume_id", "RHS"."volume_issue" AS "volume_issue", "RHS"."issue_date" AS "issue_date", "RHS"."weeks_on_top" AS "weeks_on_top", "RHS"."song" AS "song" FROM "artist" AS "LHS" INNER JOIN "volume" AS "RHS" ON ("LHS"."artist_id" = "RHS"."artist_id")) WHERE ("artist" = 'Gorgoroth') ORDER BY issue_date, "issue_date" NULLS LAST;

/*
Gold Result:
(None,)
('2020-01-01',)
('2022-01-01',)
*/

-- Prediction Query
SELECT T2.Issue_Date FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID = T2.Artist_ID WHERE T1.Artist = 'Gorgoroth';

/*
Prediction Result:
('2022-01-01',)
('2020-01-01',)
(None,)
*/