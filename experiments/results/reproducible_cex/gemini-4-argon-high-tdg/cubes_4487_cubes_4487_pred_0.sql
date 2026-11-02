-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (1, 'Spring Fest', 'Alice', 'Paris', 2020, 500);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (2, 'Summer Fest', 'Bob', 'London', 2021, 800);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (3, 'Autumn Fest', 'Carol', 'Rome', 2022, 600);
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (1, 'Sculpture', 'David');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (2, 'Sculpture', 'The Thinker');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (3, 'Painting', 'Mona Lisa');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (4, 'Painting', 'Starry Night');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (5, 'Film', 'Inception');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (5, 1, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (5, 2, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (5, 3, 'Nominated');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (1, 1, 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM (SELECT LHS.type AS TYPE, LHS.n AS n FROM (SELECT TYPE, COUNT(*) AS n FROM artwork GROUP BY TYPE) AS LHS INNER JOIN (SELECT TYPE, MAX(n) OVER () AS n FROM (SELECT TYPE, COUNT(*) AS n FROM artwork GROUP BY TYPE)) AS RHS ON (LHS.type = RHS.type AND LHS.n = RHS.n)) ORDER BY TYPE;

/*
Gold Result:
('Painting',)
('Sculpture',)
*/

-- Prediction Query
SELECT TYPE FROM artwork GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Painting',)
*/