-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1001, 'Allison Hill', 1007.5, 1013.5, 'table', 'Qatar');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1002, 'Noah Rhodes', 1014.5, 1022.5, 'true', 'Jamaica');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1003, 'Angie Henderson', 1021.5, 1031.5, 'according', 'Guam');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1004, 'Daniel Wagner', 1028.5, 1040.5, 'song', 'Fiji');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1005, 'Cristian Santos', 1035.5, 1049.5, 'sure', 'Cape Verde');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1006, 'Connie Lawrence', 1042.5, 1058.5, 'collection', 'Cuba');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RANGE FROM (SELECT RANGE FROM mountain INTERSECT SELECT RANGE FROM mountain) ORDER BY RANGE;

/*
Gold Result:
('according',)
('collection',)
('song',)
('sure',)
('table',)
('true',)
*/

-- Prediction Query
SELECT DISTINCT RANGE FROM mountain ORDER BY Prominence DESC, RANGE NULLS LAST LIMIT 3;

/*
Prediction Result:
('collection',)
('sure',)
('song',)
*/