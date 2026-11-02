-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, artist, age, famous_title, famous_release_date) VALUES (0, 'Gorgoroth', 0, 'default2', 'default1'), (1, 'default1', NULL, 'default2', NULL), (2, 'default1', NULL, 'default1', NULL), (3, NULL, 0, 'default2', NULL), (4, 'default2', NULL, 'default1', 'default1'), (5, 'default1', NULL, 'default1', 'default1'), (6, NULL, 0, 'default2', NULL), (7, 'default1', 0, 'Gorgoroth', NULL), (8, 'default2', NULL, 'default2', 'default1'), (9, NULL, NULL, 'Gorgoroth', 'default1'), (10, 'Gorgoroth', 1, NULL, 'default2'), (11, 'Gorgoroth', 0, 'default2', NULL), (12, 'default1', NULL, 'Gorgoroth', 'default1'), (13, NULL, 0, 'default2', 'default2'), (14, 'default1', NULL, 'default2', 'default2'), (15, 'default1', 0, 'Gorgoroth', NULL), (16, 'Gorgoroth', 0, 'default1', NULL);
INSERT INTO volume (volume_id, artist_id, volume_issue, issue_date, weeks_on_top, song) VALUES (1, 12, 'Gorgoroth', NULL, NULL, 'default1'), (0, 9, 'default2', 'Gorgoroth', 1.0, NULL), (2, 7, 'default2', 'Gorgoroth', NULL, NULL), (3, 7, 'default2', 'default2', 0.0, NULL), (4, 6, NULL, 'Gorgoroth', 0.0, NULL), (5, 0, 'default1', 'default1', 0.0, 'default1'), (6, 4, NULL, 'Gorgoroth', 1.0, 'default1'), (7, 9, 'Gorgoroth', 'Gorgoroth', 1.0, NULL), (8, 9, 'default1', 'Gorgoroth', 0.0, 'default1'), (9, 7, 'Gorgoroth', 'default1', NULL, 'default1'), (10, 7, 'default2', 'default1', NULL, NULL), (11, 9, 'default2', NULL, NULL, 'default1'), (12, 1, 'default1', 'default1', NULL, 'default1'), (13, 3, 'default1', 'default1', 0.0, 'Gorgoroth'), (14, 0, 'default2', 'Gorgoroth', 1.0, 'Gorgoroth'), (15, 11, NULL, 'default2', 0.0, 'default1'), (16, NULL, 'default2', 'Gorgoroth', NULL, 'Gorgoroth'), (17, 6, 'default2', 'Gorgoroth', 0.0, NULL), (18, 9, NULL, 'Gorgoroth', 0.0, NULL), (19, 14, 'Gorgoroth', 'default1', 0.0, NULL), (20, 3, 'default1', 'default2', 0.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "issue_date" FROM (SELECT "LHS"."artist_id" AS "artist_id", "LHS"."artist" AS "artist", "LHS"."age" AS "age", "LHS"."famous_title" AS "famous_title", "LHS"."famous_release_date" AS "famous_release_date", "RHS"."volume_id" AS "volume_id", "RHS"."volume_issue" AS "volume_issue", "RHS"."issue_date" AS "issue_date", "RHS"."weeks_on_top" AS "weeks_on_top", "RHS"."song" AS "song" FROM "artist" AS "LHS" INNER JOIN "volume" AS "RHS" ON ("LHS"."artist_id" = "RHS"."artist_id")) WHERE ("artist" = 'Gorgoroth') ORDER BY issue_date, "issue_date" NULLS LAST;

/*
Gold Result:
('Gorgoroth',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT T2.Issue_Date FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID = T2.Artist_ID WHERE T1.Artist = 'Gorgoroth';

/*
Prediction Result:
('default1',)
('Gorgoroth',)
('default2',)
*/