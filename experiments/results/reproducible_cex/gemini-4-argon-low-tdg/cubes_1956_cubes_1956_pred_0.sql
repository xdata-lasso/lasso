-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (1, 'Alpha Fest', 'Alice', 'New York', 2023, 5000);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (2, 'Beta Fest', 'Zack', 'London', 2021, 1000);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (3, 'Gamma Fest', 'Bob', 'Paris', 2022, 3000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT * FROM (SELECT * FROM festival_detail ORDER BY chair_name DESC, festival_detail.festival_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('London',)
*/

-- Prediction Query
SELECT LOCATION FROM festival_detail ORDER BY Num_of_Audience DESC, festival_detail.festival_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('New York',)
*/