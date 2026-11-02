-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (1, 'Spring Arts', 'Alice Smith', 'New York', 2020, 500);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (2, 'Autumn Fest', 'Bob Jones', 'London', 2021, 800);
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (1, 'Sculpture', 'Apple');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (2, 'Painting', 'Zebra');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (3, 'Painting', 'Zebra');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (4, 'Sculpture', 'Apple');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (5, 'Film', 'Mango');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (6, 'Sculpture', 'Apple');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (1, 1, 'Awarded');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (4, 2, 'Nominated');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (5, 1, 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM (SELECT * FROM (SELECT * FROM (SELECT name, TYPE, COUNT(*) AS n FROM artwork GROUP BY name, TYPE) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
('Painting',)
*/

-- Prediction Query
SELECT TYPE FROM artwork GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Sculpture',)
*/