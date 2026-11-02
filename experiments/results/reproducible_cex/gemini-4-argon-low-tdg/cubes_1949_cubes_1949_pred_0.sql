-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (1, 'Sculpture', 'Alpha');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (2, 'Sculpture', 'Alpha');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (3, 'Sculpture', 'Alpha');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (4, 'Painting', 'Beta');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (5, 'Painting', 'Beta');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (6, 'Photograph', 'Zeta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM (SELECT * FROM (SELECT * FROM (SELECT name, TYPE, COUNT(*) AS n FROM artwork GROUP BY name, TYPE) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
('Photograph',)
*/

-- Prediction Query
SELECT TYPE FROM artwork GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Sculpture',)
*/