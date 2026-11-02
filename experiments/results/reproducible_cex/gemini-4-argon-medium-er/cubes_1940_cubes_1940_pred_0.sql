-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (1, 'Zeta Festival', 'John Doe', 'New York', 2020, 500);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (2, 'Alpha Festival', 'Jane Smith', 'Los Angeles', 2021, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT festival_name, LOCATION FROM festival_detail ORDER BY festival_name, festival_detail.festival_id NULLS LAST;

/*
Gold Result:
('Alpha Festival', 'Los Angeles')
('Zeta Festival', 'New York')
*/

-- Prediction Query
SELECT Festival_Name, LOCATION FROM festival_detail;

/*
Prediction Result:
('Zeta Festival', 'New York')
('Alpha Festival', 'Los Angeles')
*/