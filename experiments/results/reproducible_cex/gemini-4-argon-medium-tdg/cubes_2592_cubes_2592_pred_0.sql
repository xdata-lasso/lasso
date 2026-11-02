-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'Gorgoroth', 30, 'Pentagram', '1994-10-12');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (2, 'Emperor', 32, 'Gorgoroth', '1999-05-01');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (3, 'gorgoroth', 28, 'Antichrist', '1996-06-06');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (4, 'Gorgoroth Band', 35, 'Destroyer', '1998-05-18');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (5, NULL, 40, 'Unknown', '2000-01-01');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (10, 1, '456:90', '2002-12-28', 2.0, 'Procreating Satan');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (20, 1, '457:10', '1998-05-01', 1.5, 'Destroyer');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (30, 1, '458:12', '1998-05-01', 3.0, 'Incipit Satan');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (40, 2, '100:01', '2005-01-01', 5.0, 'Gorgoroth');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (50, 3, '101:02', '2006-02-02', 4.0, 'Possessed');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (60, 4, '102:03', '2007-03-03', 1.0, 'Carving a Giant');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (70, 5, '103:04', '2008-04-04', 2.0, 'Sign of an Open Eye');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (1, 2, '999:99', '2010-10-10', 10.0, 'Cross Join Trap');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (1, 10, 'Bergen Fest', '2003-01-15', 'Best Black Metal', 'Nominated');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (2, 10, 'Oslo Metal Awards', '2003-03-20', 'Album of the Year', 'Awarded');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "issue_date" FROM (SELECT "LHS"."artist_id" AS "artist_id", "LHS"."artist" AS "artist", "LHS"."age" AS "age", "LHS"."famous_title" AS "famous_title", "LHS"."famous_release_date" AS "famous_release_date", "RHS"."volume_id" AS "volume_id", "RHS"."volume_issue" AS "volume_issue", "RHS"."issue_date" AS "issue_date", "RHS"."weeks_on_top" AS "weeks_on_top", "RHS"."song" AS "song" FROM "artist" AS "LHS" INNER JOIN "volume" AS "RHS" ON ("LHS"."artist_id" = "RHS"."artist_id")) WHERE ("artist" = 'Gorgoroth') ORDER BY issue_date, "issue_date" NULLS LAST;

/*
Gold Result:
('1998-05-01',)
('1998-05-01',)
('2002-12-28',)
*/

-- Prediction Query
SELECT T2.Issue_Date FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID = T2.Artist_ID WHERE T1.Artist = 'Gorgoroth';

/*
Prediction Result:
('2002-12-28',)
('1998-05-01',)
('1998-05-01',)
*/