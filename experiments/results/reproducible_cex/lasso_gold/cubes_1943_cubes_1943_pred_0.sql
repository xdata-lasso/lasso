-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1013, 'win', 'Matthew Mejia');
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1014, 'present', 'Juan Calderon');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "artwork" WHERE ("type" <> 'Program Talent Show') ORDER BY name, artwork.artwork_id NULLS LAST;

/*
Gold Result:
('Juan Calderon',)
('Matthew Mejia',)
*/

-- Prediction Query
SELECT Name FROM artwork WHERE TYPE <> 'Program Talent Show';

/*
Prediction Result:
('Matthew Mejia',)
('Juan Calderon',)
*/