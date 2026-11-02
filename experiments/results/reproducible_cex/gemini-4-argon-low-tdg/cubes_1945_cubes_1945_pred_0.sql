-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (1, 'Zulu Fest', 'Alice', 'Berlin', 2022, 5000);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (2, 'Alpha Fest', 'Bob', 'Cairo', 2021, 100);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (3, 'Mid Fest', 'Alice', 'Athens', 1995, 2500);
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (10, 'Painting', 'Sunset');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (10, 1, 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT YEAR FROM (SELECT * FROM (SELECT * FROM (SELECT festival_id, festival_name, chair_name, LOCATION, YEAR, num_of_audience, COUNT(*) OVER () AS n FROM festival_detail) ORDER BY festival_name) LIMIT 1);

/*
Gold Result:
(2021,)
*/

-- Prediction Query
SELECT YEAR FROM festival_detail GROUP BY YEAR HAVING COUNT(*) > 1;

/*
Prediction Result:
*/