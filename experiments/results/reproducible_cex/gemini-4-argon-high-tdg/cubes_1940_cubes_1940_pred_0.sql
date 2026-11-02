-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (10, 'Zeta Fest', 'Alice', 'Berlin', 2018, 500);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (20, 'Alpha Fest', 'Zack', 'Zurich', 2022, 9000);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (30, 'Alpha Fest', 'Bob', 'Amsterdam', 1995, 100);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (40, 'Beta Fest', 'Carol', 'London', 2010, 1500);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (50, 'Beta Fest', 'Dave', 'London', 2012, 2000);
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (1, 'Painting', 'Sunflowers');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (2, 'Sculpture', 'The Thinker');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (1, 10, 'Winner');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (2, 10, 'Nominated');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (1, 20, 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT festival_name, LOCATION FROM festival_detail ORDER BY festival_name, festival_detail.festival_id NULLS LAST;

/*
Gold Result:
('Alpha Fest', 'Zurich')
('Alpha Fest', 'Amsterdam')
('Beta Fest', 'London')
('Beta Fest', 'London')
('Zeta Fest', 'Berlin')
*/

-- Prediction Query
SELECT Festival_Name, LOCATION FROM festival_detail;

/*
Prediction Result:
('Zeta Fest', 'Berlin')
('Alpha Fest', 'Zurich')
('Alpha Fest', 'Amsterdam')
('Beta Fest', 'London')
('Beta Fest', 'London')
*/