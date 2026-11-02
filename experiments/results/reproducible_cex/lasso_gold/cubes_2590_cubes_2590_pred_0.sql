-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1014, 'mouth', 1015, 'Production assistant, radio', 'agreement');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1016, 'option', 1015, 'Town planner', 'sense');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1018, 'rate', 1016, 'Theme park manager', 'discussion');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT famous_title, age FROM artist ORDER BY famous_title, artist.artist_id NULLS LAST;

/*
Gold Result:
('Production assistant, radio', 1015)
('Theme park manager', 1016)
('Town planner', 1015)
*/

-- Prediction Query
SELECT Famous_Title, Age FROM artist ORDER BY Age DESC, artist.artist_id NULLS LAST;

/*
Prediction Result:
('Theme park manager', 1016)
('Production assistant, radio', 1015)
('Town planner', 1015)
*/