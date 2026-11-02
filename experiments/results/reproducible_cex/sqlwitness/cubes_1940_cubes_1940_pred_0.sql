-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO festival_detail (festival_id, festival_name, chair_name, location, year, num_of_audience) VALUES (0, 'default2', 'default2', NULL, 0, 1), (1, 'default1', NULL, NULL, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT festival_name, LOCATION FROM festival_detail ORDER BY festival_name, festival_detail.festival_id NULLS LAST;

/*
Gold Result:
('default1', None)
('default2', None)
*/

-- Prediction Query
SELECT Festival_Name, LOCATION FROM festival_detail;

/*
Prediction Result:
('default2', None)
('default1', None)
*/