-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Peak Exactly 5600', 5600.0, 5600.0, 'Andes', 'Peru');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (2, 'Peak Just Above 5600', 5600.1, 1000.0, 'Himalayas', 'Nepal');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (3, 'Peak Just Below 5600', 5599.9, 6000.0, 'Alps', 'Switzerland');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (4, 'Peak Exactly 5200', 5200.0, 2000.0, 'Rockies', 'Canada');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (5, 'Peak Just Above 5200', 5200.1, 5200.0, 'Caucasus', 'Georgia');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (6, 'Peak Just Below 5200', 5199.9, 5200.0, 'Urals', 'Russia');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM mountain WHERE (height > 5600.0 OR height = 5200.0) ORDER BY country, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('Canada',)
('Nepal',)
*/

-- Prediction Query
SELECT Country FROM mountain WHERE Height > 5600 INTERSECT SELECT Country FROM mountain WHERE Height < 5200;

/*
Prediction Result:
*/