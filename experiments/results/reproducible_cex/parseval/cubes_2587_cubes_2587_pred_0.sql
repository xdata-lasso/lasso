-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: artist --
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1, 'art_a69cde', 1, 'art_d15bcc', 'art_7ba28f');

INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (-2147483647, 'art_bc2107', 1, 'art_2924dd', 'art_703597');

INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (2, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (-2147483648, 'hsrwbbp', 13244799, 'hvdltt', 'lbn');

INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (-2147483644, 'rmdp', 2026480202, 'ie5', 'q_1_711bed');

INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (-2147483643, 'nw6klf', 1038707349, '9000t5c4ec', 'q_1_711bed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT famous_release_date FROM (SELECT * FROM (SELECT * FROM artist ORDER BY artist_id DESC) LIMIT 1);

/*
Gold Result:
('hria2ypu',)
*/

-- Prediction Query
SELECT Famous_Release_date FROM artist ORDER BY Age DESC, artist.artist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_1_711bed',)
*/