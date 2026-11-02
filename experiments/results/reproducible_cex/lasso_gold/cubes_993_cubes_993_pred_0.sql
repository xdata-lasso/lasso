-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (1010, 'Michele Williams', '31647 Martin Knoll Apt. 419
New Jessica, GA 61090', 1011.5, 1012.5);
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (1014, 'Sarah Parsons', '6413 Lewis Parks
Wilkersonmouth, FL 35219', 1015.5, 1016.5);
INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (1013, 1010, 'William Bowman', 'onto', 'discuss');
INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (1017, 1014, 'Kevin Cox', 'skin', 'pattern');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, CLASS, date FROM race ORDER BY name, race.race_id NULLS LAST;

/*
Gold Result:
('Kevin Cox', 'skin', 'pattern')
('William Bowman', 'onto', 'discuss')
*/

-- Prediction Query
SELECT name, CLASS, date FROM race;

/*
Prediction Result:
('William Bowman', 'onto', 'discuss')
('Kevin Cox', 'skin', 'pattern')
*/