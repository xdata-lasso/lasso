-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (1, 'Summer Fest', 'Alice', 'NY', 2020, 500);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (2, 'Winter Fest', 'Bob', 'LA', 2021, 1000);
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (1, 'Program Talent Show', 'Alpha');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (2, 'Painting', 'Beta');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (3, 'Sculpture', 'Beta');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (4, 'Music', 'Alpha');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (5, 'Program Talent Show', 'Gamma');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (1, 1, 'Won');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (2, 1, 'Nominated');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (2, 2, 'Won');
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