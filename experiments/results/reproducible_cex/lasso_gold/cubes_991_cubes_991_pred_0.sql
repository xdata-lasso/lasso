-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (1004, 'Matthew Gardner', '26542 Susan Junction Apt. 161
Melanieview, AS 06196', 1005.5, 1006.5);
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (1007, 'Matthew Gardner', '26542 Susan Junction Apt. 161
Melanieview, AS 06196', 1005.5, 1006.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM track ORDER BY LOCATION, track.track_id NULLS LAST;

/*
Gold Result:
('26542 Susan Junction Apt. 161\nMelanieview, AS 06196',)
('26542 Susan Junction Apt. 161\nMelanieview, AS 06196',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM track;

/*
Prediction Result:
('26542 Susan Junction Apt. 161\nMelanieview, AS 06196',)
*/