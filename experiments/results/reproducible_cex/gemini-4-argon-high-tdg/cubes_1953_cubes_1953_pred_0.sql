-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (1, 'Zeta Gala', 'Alice', 'Rome', 2007, 100);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (2, 'Alpha Gala', 'Zack', 'Madrid', 2007, 300);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (3, 'Mu Gala', 'Middle', 'Vienna', 2007, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT festival_name FROM festival_detail WHERE (YEAR = 2007) ORDER BY festival_name, festival_detail.festival_id NULLS LAST;

/*
Gold Result:
('Alpha Gala',)
('Mu Gala',)
('Zeta Gala',)
*/

-- Prediction Query
SELECT Festival_Name FROM festival_detail WHERE YEAR = 2007;

/*
Prediction Result:
('Zeta Gala',)
('Alpha Gala',)
('Mu Gala',)
*/