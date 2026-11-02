-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (1, 'Spring Fest', 'Zack', 'New York', 2020, 500);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (2, 'Summer Gala', 'Alice', 'London', 2021, 1200);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (3, 'Autumn Show', 'Alice', 'Paris', 2019, 800);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (4, 'Winter Expo', 'Bob', 'Tokyo', 2022, 300);
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (10, 'Painting', 'Sunset');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (20, 'Sculpture', 'The Thinker');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (10, 1, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (20, 1, 'Nominated');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (10, 2, 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT chair_name FROM festival_detail ORDER BY chair_name, festival_detail.festival_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT Chair_Name FROM festival_detail ORDER BY YEAR ASC, festival_detail.festival_id NULLS LAST;

/*
Prediction Result:
('Alice',)
('Zack',)
('Alice',)
('Bob',)
*/