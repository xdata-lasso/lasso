-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (1005, 'Rhonda Smith', '4235 Christopher Court Suite 594
Lake Stephenville, MS 10829', 1006.5, 1007.5);
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (1009, 'Michele Williams', '31647 Martin Knoll Apt. 419
New Jessica, GA 61090', 1010.5, 1011.5);
INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (1008, 1005, 'Sandra Montgomery', 'training', 'high');
INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (1012, NULL, 'William Bowman', 'onto', 'discuss');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CLASS FROM (SELECT CLASS, n, MAX(n) OVER () AS maxn FROM (SELECT CLASS, COUNT(*) AS n FROM race GROUP BY CLASS)) WHERE (maxn = n) ORDER BY CLASS;

/*
Gold Result:
('onto',)
('training',)
*/

-- Prediction Query
SELECT CLASS FROM race GROUP BY CLASS ORDER BY COUNT(*) DESC, CLASS NULLS LAST LIMIT 1;

/*
Prediction Result:
('onto',)
*/