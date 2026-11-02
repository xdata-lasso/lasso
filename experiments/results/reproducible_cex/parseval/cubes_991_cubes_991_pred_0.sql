-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: track --
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (1, '5k5swwqcgs', 'tra_4b600d', 171.746906, 557.512061);

INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (3, '8c4pgu7vfe', 'tra_4b600d', 483.665643, 818.685402);

INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (2, 'ri', NULL, 710.998147, 945.642658);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM track ORDER BY LOCATION, track.track_id NULLS LAST;

/*
Gold Result:
(None,)
('tra_4b600d',)
('tra_4b600d',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM track;

/*
Prediction Result:
('tra_4b600d',)
(None,)
*/