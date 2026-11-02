-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (10, 'Zebra Fest', 'Bob', 'Paris', 2025, 5000);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (30, 'Midsummer', 'Zack', 'Tokyo', 2021, 2000);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (20, 'Alpha Fest', 'Alice', 'London', 2018, 1000);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (40, 'Omega Fest', 'Charlie', 'Berlin', 2023, 9000);
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (1, 'Painting', 'Sunflowers');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (2, 'Sculpture', 'The Thinker');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (1, 10, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (2, 20, 'Nominated');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (1, 40, 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT * FROM (SELECT * FROM festival_detail ORDER BY chair_name DESC, festival_detail.festival_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Tokyo',)
*/

-- Prediction Query
SELECT LOCATION FROM festival_detail ORDER BY Num_of_Audience DESC, festival_detail.festival_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Berlin',)
*/