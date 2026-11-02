-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Mount Boundary', 5000.0, 2000.0, 'Range A', 'Peru');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (2, 'Mount Just Below', 4999.9, 1500.0, 'Range B', 'Chile');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (3, 'Mount Just Above', 5000.1, 2500.0, 'Range C', 'Nepal');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (4, 'Mount Low', 3000.0, 6000.0, 'Range D', 'India');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM mountain WHERE (height >= 5000.0) ORDER BY country, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('Nepal',)
('Peru',)
*/

-- Prediction Query
SELECT Country FROM mountain WHERE Height > 5000;

/*
Prediction Result:
('Nepal',)
*/