-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1005, 'chair', 'Megan Mcclain');
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1006, 'chair', 'Megan Mcclain');
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1007, 'chair', 'Megan Mcclain');
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1008, 'chair', 'Megan Mcclain');
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1017, 'mouth', NULL);
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1018, 'mouth', NULL);
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1019, 'mouth', NULL);
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1020, 'mouth', NULL);
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1021, 'mouth', 'Jennifer Cole');
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1022, 'mouth', 'Jennifer Cole');
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1023, 'mouth', 'Jennifer Cole');
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1024, 'mouth', 'Jennifer Cole');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM (SELECT * FROM (SELECT * FROM (SELECT name, TYPE, COUNT(*) AS n FROM artwork GROUP BY name, TYPE) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
('chair',)
*/

-- Prediction Query
SELECT TYPE FROM artwork GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('mouth',)
*/