-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (1, 'Spring Arts', 'Alice Green', 'New York', 2021, 500);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (3, 'Winter Gala', 'Bob White', 'London', 2022, 1200);
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (1, 'A_Painting', 'Zebra Crossing');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (2, 'M_Sculpture', 'Marble Statue');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (3, 'Z_Photography', 'Autumn Leaves');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (4, 'B_Drawing', 'Charcoal Sketch');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (2, 1, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (2, 3, 'Lost');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (4, 1, 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM artwork AS LHS WHERE NOT EXISTS(SELECT 1 FROM nomination AS RHS WHERE (LHS.artwork_id = RHS.artwork_id))) ORDER BY name;

/*
Gold Result:
('Autumn Leaves',)
('Zebra Crossing',)
*/

-- Prediction Query
SELECT Name FROM Artwork WHERE NOT Artwork_ID IN (SELECT Artwork_ID FROM nomination);

/*
Prediction Result:
('Zebra Crossing',)
('Autumn Leaves',)
*/