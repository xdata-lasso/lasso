-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests duplicate elimination (DISTINCT), unsorted insertion order (ORDER BY), and Joins/FK mismatches (artists with 0, 1, and multiple volumes/festivals, plus differing Issue_Date and Date_of_ceremony values).
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'The Echoes', 32, 'Midnight Sun', '2005-10-12');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (2, 'Starlight', 25, 'Supernova', '1998-03-25');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (3, 'Blue Horizon', 40, 'Ocean Deep', '2005-10-12');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (4, 'Velvet Underground', 55, 'Heroin', '2012-07-04');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (101, 1, 'Vol. 1', '2006-01-01', 4.5, 'Sunbeam');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (102, 1, 'Vol. 2', '2007-02-01', 2.0, 'Moonlight');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (103, 2, 'Vol. 9', '1999-11-11', 10.0, 'Pulsar');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (1001, 101, 'Global Music Awards', '2006-05-20', 'Best Rock', 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT famous_release_date FROM artist ORDER BY famous_release_date;

/*
Gold Result:
('1998-03-25',)
('2005-10-12',)
('2012-07-04',)
*/

-- Prediction Query
SELECT DISTINCT (Famous_Release_date) FROM artist;

/*
Prediction Result:
('2005-10-12',)
('1998-03-25',)
('2012-07-04',)
*/