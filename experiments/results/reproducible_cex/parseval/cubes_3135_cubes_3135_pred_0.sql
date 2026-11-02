-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: artist --
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1, 'art_4e62b7', 'art_876132', 1, 1);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483647, 'art_f12826', 'art_c33bb5', 1, 1);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-1, '5', '5k5swwqcgs', 247012447, -1980249628);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (0, '4', 'gu7v', -1865039888, 1160656988);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483644, 'q_1_2af756', 'ia2yp', -1670923962, 700293388);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483643, 'q_1_2af756', 'wbbp6luhvdlt', -841692980, -1364429300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM artist ORDER BY name DESC, artist.artist_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('q_1_2af756',)
*/

-- Prediction Query
SELECT name FROM artist ORDER BY year_join DESC, artist.artist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('5',)
*/