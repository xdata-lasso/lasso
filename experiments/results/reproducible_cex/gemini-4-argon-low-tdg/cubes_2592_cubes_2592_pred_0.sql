-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'Gorgoroth', 40, 'Pentagram', '1994-10-12');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (2, 'Mayhem', 38, 'De Mysteriis Dom Sathanas', '1994-05-24');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (3, 'Gorgoroth', 45, 'Antichrist', '1996-06-03');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (10, 1, 'Issue 2', '2000-05-01', 3.5, 'Ritual');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (11, 1, 'Issue 1', '1998-01-15', 1.0, 'Katharinas Bortgang');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (12, 2, 'Issue 3', '1995-11-20', 5.0, 'Freezing Moon');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (100, 10, 'Bergen Fest', '2001-01-01', 'Best Metal', 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "issue_date" FROM (SELECT "LHS"."artist_id" AS "artist_id", "LHS"."artist" AS "artist", "LHS"."age" AS "age", "LHS"."famous_title" AS "famous_title", "LHS"."famous_release_date" AS "famous_release_date", "RHS"."volume_id" AS "volume_id", "RHS"."volume_issue" AS "volume_issue", "RHS"."issue_date" AS "issue_date", "RHS"."weeks_on_top" AS "weeks_on_top", "RHS"."song" AS "song" FROM "artist" AS "LHS" INNER JOIN "volume" AS "RHS" ON ("LHS"."artist_id" = "RHS"."artist_id")) WHERE ("artist" = 'Gorgoroth') ORDER BY issue_date, "issue_date" NULLS LAST;

/*
Gold Result:
('1998-01-15',)
('2000-05-01',)
*/

-- Prediction Query
SELECT T2.Issue_Date FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID = T2.Artist_ID WHERE T1.Artist = 'Gorgoroth';

/*
Prediction Result:
('2000-05-01',)
('1998-01-15',)
*/