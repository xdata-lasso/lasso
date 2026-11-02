-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: artist --
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu');

-- Inserting into table: volume --
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1, 1, 'vol_c79a2a', 'vol_92d1e3', 1.0, 'vol_c51a6c');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (-2147483647, 1, 'vol_815c85', 'vol_2f669b', 1.0, 'vol_9ee897');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (-1, 1, 'sr', 'wbbp6luhvdlt', 304.02808, 'bnp');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (0, 1, 'mdpos', 'ie5', 327.753528, 'w6kl');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (-2147483644, 1, 'a9000t5c4eci', 'gce376nium52', 816.814398, 'q_1_f8f72e');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (-2147483643, 1, 'u', '4nrq', 597.420508, 'q_1_f8f72e');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT song FROM (SELECT * FROM (SELECT * FROM volume ORDER BY artist_id, volume.volume_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('vol_9ee897',)
*/

-- Prediction Query
SELECT Song FROM volume ORDER BY Weeks_on_Top DESC, volume.volume_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_1_f8f72e',)
*/