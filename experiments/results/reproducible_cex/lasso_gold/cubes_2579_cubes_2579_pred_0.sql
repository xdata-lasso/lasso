-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1014, 'agreement', 23, 'Surveyor, mining', 'decide');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1017, 'offer', -23, 'Personnel officer', 'discussion');
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1015, 1014, 'sense', 'rate', 1016.5, 'science');
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1018, 1017, 'list', 'perform', 1019.5, 'fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT issue_date FROM (SELECT LHS.artist_id AS artist_id, LHS.artist AS artist, LHS.age AS age, LHS.famous_title AS famous_title, LHS.famous_release_date AS famous_release_date, RHS.volume_id AS volume_id, RHS.volume_issue AS volume_issue, RHS.issue_date AS issue_date, RHS.weeks_on_top AS weeks_on_top, RHS.song AS song FROM artist AS LHS INNER JOIN volume AS RHS ON (LHS.artist_id = RHS.artist_id)) WHERE (age <= 23) ORDER BY issue_date;

/*
Gold Result:
('perform',)
('rate',)
*/

-- Prediction Query
SELECT Issue_Date FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID = T2.Artist_ID WHERE T1.age <= 23;

/*
Prediction Result:
('rate',)
('perform',)
*/