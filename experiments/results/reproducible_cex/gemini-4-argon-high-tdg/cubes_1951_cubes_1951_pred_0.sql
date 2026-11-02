-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (1, 'Spring Fest', 'Alice', 'New York', 2007, 150);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (2, 'Summer Gala', 'Bob', 'Chicago', 2008, 900);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (3, 'Autumn Expo', 'Charlie', 'Boston', 2009, 400);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (4, 'Winter Show', 'Diana', 'Seattle', 2010, 700);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (5, 'Modern Art', 'Evan', 'Austin', 2011, 200);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (6, 'Future Vision', 'Fiona', 'Miami', 2012, 400);
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (101, 'Painting', 'Sunset');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (102, 'Sculpture', 'Bronze Horse');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (101, 1, 'Nominated');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (101, 2, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (102, 2, 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT num_of_audience FROM festival_detail WHERE (YEAR >= 2008 OR YEAR > 2010) ORDER BY num_of_audience, festival_detail.festival_id NULLS LAST;

/*
Gold Result:
(200,)
(400,)
(400,)
(700,)
(900,)
*/

-- Prediction Query
SELECT Num_of_Audience FROM festival_detail WHERE YEAR = 2008 OR YEAR = 2010;

/*
Prediction Result:
(900,)
(700,)
*/