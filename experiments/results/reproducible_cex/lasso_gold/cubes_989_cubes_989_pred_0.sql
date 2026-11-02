-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (1008, 'Kimberly Dudley', '283 Steven Groves
Lake Mark, WI 07832', 1009.5, 1010.5);
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (1011, 'Andrew Stewart', '959 Janet Cape Apt. 413
South Joshuastad, GA 49021', 1010.5, 1011.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM track ORDER BY name, track.track_id NULLS LAST;

/*
Gold Result:
('Andrew Stewart', '959 Janet Cape Apt. 413\nSouth Joshuastad, GA 49021')
('Kimberly Dudley', '283 Steven Groves\nLake Mark, WI 07832')
*/

-- Prediction Query
SELECT name, LOCATION FROM track;

/*
Prediction Result:
('Kimberly Dudley', '283 Steven Groves\nLake Mark, WI 07832')
('Andrew Stewart', '959 Janet Cape Apt. 413\nSouth Joshuastad, GA 49021')
*/