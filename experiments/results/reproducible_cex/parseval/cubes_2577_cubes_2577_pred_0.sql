-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: artist --
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu');

-- Inserting into table: volume --
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1, 1, 'lhs_15ed6e', 'lhs_734e22', 1.0, 'lhs_2666ae');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (-2147483647, 1, 'lhs_fba1f0', 'lhs_67853a', 1.0, 'lhs_0e6847');

-- Inserting into table: music_festival --
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (1, 1, 'mus_7dbf04', 'mus_4da82a', 'mus_79efca', 'Nominated');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483647, 1, 'mus_0828a3', 'mus_89464a', 'mus_77a106', 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song" FROM (SELECT "LHS"."volume_id" AS "volume_id", "LHS"."volume_issue" AS "volume_issue", "LHS"."issue_date" AS "issue_date", "LHS"."weeks_on_top" AS "weeks_on_top", "LHS"."song" AS "song", "LHS"."artist_id" AS "artist_id", "RHS"."music_festival" AS "music_festival", "RHS"."date_of_ceremony" AS "date_of_ceremony", "RHS"."category" AS "category", "RHS"."volume" AS "volume", "RHS"."result" AS "result" FROM "volume" AS "LHS" INNER JOIN (SELECT * FROM "music_festival" WHERE ("result" = 'Nominated')) AS RHS ON (LHS.volume_id = RHS.id)) ORDER BY song, "song" NULLS LAST;

/*
Gold Result:
('lhs_0e6847',)
('lhs_2666ae',)
*/

-- Prediction Query
SELECT T2.Song FROM music_festival AS T1 JOIN volume AS T2 ON T1.Volume = T2.Volume_ID WHERE T1.Result = 'Nominated';

/*
Prediction Result:
('lhs_2666ae',)
('lhs_2666ae',)
*/