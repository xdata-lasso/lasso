-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (1, 'Program Talent Show', 'Alpha');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (2, 'Presenter', 'Beta');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (3, 'Performance', 'Beta');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (4, 'Presenter', 'Alpha');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "artwork" WHERE ("type" <> 'Program Talent Show') ORDER BY name, artwork.artwork_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Beta',)
('Beta',)
*/

-- Prediction Query
SELECT Name FROM artwork WHERE TYPE <> 'Program Talent Show';

/*
Prediction Result:
('Beta',)
('Beta',)
('Alpha',)
*/