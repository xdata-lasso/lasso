-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (1, 'FilmFest', 'Alice', 'Berlin', 2020, 5000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (2, 'ArtExpo', 'Bob', 'Berlin', 2021, 3000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (3, 'MusicBash', 'Charlie', 'Amsterdam', 2019, 10000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (4, 'CineWorld', 'David', 'Cannes', 2022, 8000);
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (101, 'Painting', 'Sunflowers');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (102, 'Sculpture', 'The Thinker');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (101, 1, 'Won');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (102, 2, 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT festival_id, LOCATION, MAX(num_of_audience) AS num_of_audience FROM festival_detail GROUP BY festival_id, LOCATION) ORDER BY LOCATION;

/*
Gold Result:
('Amsterdam',)
('Berlin',)
('Cannes',)
*/

-- Prediction Query
SELECT LOCATION FROM festival_detail ORDER BY Num_of_Audience DESC, festival_detail.festival_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Amsterdam',)
*/