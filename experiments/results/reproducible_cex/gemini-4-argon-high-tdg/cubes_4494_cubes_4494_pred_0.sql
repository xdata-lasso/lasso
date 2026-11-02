-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (1, 'Summer Fest', 'Alice Smith', 'Paris', 2020, 5000);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (2, 'Winter Gala', 'Bob Jones', 'Tokyo', 2018, 700);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (3, 'Spring Art', 'Charlie Kim', 'Berlin', 2015, 2000);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (4, 'Autumn Expo', 'Diana Ross', 'Tokyo', 2022, 600);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (5, 'Indie Showcase', 'Evan Wright', 'Berlin', 2023, 1500);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (6, 'Classic Night', 'Fiona Gallagher', 'Tokyo', 2019, 500);
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (101, 'Painting', 'Sunset');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (102, 'Sculpture', 'The Thinker');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (101, 1, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (102, 2, 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT festival_id, LOCATION, MAX(num_of_audience) AS num_of_audience FROM festival_detail GROUP BY festival_id, LOCATION) ORDER BY LOCATION;

/*
Gold Result:
('Berlin',)
('Paris',)
('Tokyo',)
*/

-- Prediction Query
SELECT LOCATION FROM festival_detail ORDER BY Num_of_Audience DESC, festival_detail.festival_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Paris',)
*/