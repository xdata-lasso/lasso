-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1001, 'Allison Hill', 5000.0, 0.0, 'dog', 'Burundi');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM mountain WHERE (height >= 5000.0 AND prominence <> 1000.0) ORDER BY name, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('Allison Hill',)
*/

-- Prediction Query
SELECT Name FROM mountain WHERE Height > 5000 OR Prominence > 1000;

/*
Prediction Result:
*/