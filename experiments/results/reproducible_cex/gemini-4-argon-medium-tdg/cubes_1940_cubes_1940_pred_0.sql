-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (1, 'Zeta Fest', 'Alice', 'New York', 2020, 5000);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (2, 'Alpha Fest', 'Bob', 'London', 2021, 3000);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (3, 'Alpha Fest', 'Charlie', 'Paris', 2019, 8000);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (4, 'Beta Fest', 'David', 'Berlin', 2022, 1000);
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (101, 'Painting', 'Sunset');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (102, 'Sculpture', 'Thinker');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (101, 1, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (102, 1, 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT festival_name, LOCATION FROM festival_detail ORDER BY festival_name, festival_detail.festival_id NULLS LAST;

/*
Gold Result:
('Alpha Fest', 'London')
('Alpha Fest', 'Paris')
('Beta Fest', 'Berlin')
('Zeta Fest', 'New York')
*/

-- Prediction Query
SELECT Festival_Name, LOCATION FROM festival_detail;

/*
Prediction Result:
('Zeta Fest', 'New York')
('Alpha Fest', 'London')
('Alpha Fest', 'Paris')
('Beta Fest', 'Berlin')
*/