-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (1, 'Painting', 'B');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (2, 'Painting', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM artwork AS LHS WHERE NOT EXISTS(SELECT 1 FROM nomination AS RHS WHERE (LHS.artwork_id = RHS.artwork_id))) ORDER BY name;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT Name FROM Artwork WHERE NOT Artwork_ID IN (SELECT Artwork_ID FROM nomination);

/*
Prediction Result:
('B',)
('A',)
*/