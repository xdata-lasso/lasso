-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by festival_name, duplicate elimination (SELECT DISTINCT), and tie-breaking by festival_id (when Locations are identical vs distinct).
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (1, 'Sundance', 'John Doe', 'Utah', 2020, 5000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (2, 'Cannes', 'Jane Roe', 'Paris', 2021, 10000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (3, 'Cannes', 'Alice Smith', 'Nice', 2019, 8000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (4, 'Berlin', 'Bob Brown', 'Munich', 2022, 6000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (5, 'Berlin', 'Charlie Black', 'Munich', 2023, 7000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT festival_name, LOCATION FROM festival_detail ORDER BY festival_name, festival_detail.festival_id NULLS LAST;

/*
Gold Result:
('Berlin', 'Munich')
('Berlin', 'Munich')
('Cannes', 'Paris')
('Cannes', 'Nice')
('Sundance', 'Utah')
*/

-- Prediction Query
SELECT Festival_Name, LOCATION FROM festival_detail;

/*
Prediction Result:
('Sundance', 'Utah')
('Cannes', 'Paris')
('Cannes', 'Nice')
('Berlin', 'Munich')
('Berlin', 'Munich')
*/