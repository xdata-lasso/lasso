-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: artist --
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (-2147483648, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1, '5u', 1861536320, '6klfa9', '00t5c4e');

-- Inserting into table: volume --
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1, -2147483648, 'hsrwbbp', 'luhvdltti', 182.319045, 'nprmdposii');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (2, -2147483648, 'gce', '76nium52', 816.814398, 'buo4nrq');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (3, 1, 'fqyp', 's5bbp02e', 325.080047, 'iqa');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (4, 1, 'ryytoo3', '9hl7', 443.457804, 'lex');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (5, 1, 'ji7zwau2', 'dwyrq13pyu78', 49.538289, 'rljsl0b4y');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (6, -2147483648, 'qi2rkf9v', 'x58pz', 410.133844, '8j');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (7, -2147483648, 'd2', 'vy9uxj4', 124.573829, 'd');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (8, 1, 'ph2', 'nd', 893.16532, 'wnqcx');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (9, 1, 'hncprjtu0dz', '9fjgq8n2f', 456.127515, 'q');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT song FROM (SELECT volume_id, volume_issue, issue_date, weeks_on_top, song, volume_id AS artist_id, maxweeks_on_top, volume_id_other, volume_issue_other, issue_date_other, song_other, maxweeks_on_top_other FROM (SELECT LHS.volume_id AS volume_id, LHS.volume_issue AS volume_issue, LHS.issue_date AS issue_date, LHS.weeks_on_top AS weeks_on_top, LHS.song AS song, LHS.artist_id AS artist_id, LHS.maxweeks_on_top AS maxweeks_on_top, RHS.volume_id AS volume_id_other, RHS.volume_issue AS volume_issue_other, RHS.issue_date AS issue_date_other, RHS.song AS song_other, RHS.maxweeks_on_top AS maxweeks_on_top_other FROM (SELECT volume_id, volume_issue, issue_date, weeks_on_top, song, artist_id, MAX(weeks_on_top) OVER () AS maxweeks_on_top FROM volume) AS LHS INNER JOIN (SELECT volume_id, volume_issue, issue_date, weeks_on_top, song, artist_id, MAX(weeks_on_top) OVER () AS maxweeks_on_top FROM volume) AS RHS ON (LHS.volume_id = RHS.artist_id AND LHS.maxweeks_on_top = RHS.weeks_on_top))) ORDER BY song;

/*
Gold Result:
('nprmdposii',)
*/

-- Prediction Query
SELECT Song FROM volume ORDER BY Weeks_on_Top DESC, volume.volume_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('wnqcx',)
*/