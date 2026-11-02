-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (1, 'Zeta Festival', 'John Doe', 'New York', 2007, 2007);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (2, 'Alpha Festival', 'Jane Smith', 'London', 2007, 1000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (3, 'Alpha Festival', 'Bob Brown', 'Paris', 2007, 5000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (4, 'Beta Festival', 'Alice White', 'Berlin', 2006, 2007);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (5, 'Gamma Festival', 'Charlie Black', 'Tokyo', 2008, 3000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (6, 'Delta Festival', 'Eve Green', 'Rome', NULL, 2007);
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (101, 'Painting', '2007');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (102, 'Sculpture', 'The Thinker');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (101, 1, 'Won');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (102, 1, 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT festival_name FROM festival_detail WHERE (YEAR = 2007) ORDER BY festival_name, festival_detail.festival_id NULLS LAST;

/*
Gold Result:
('Alpha Festival',)
('Alpha Festival',)
('Zeta Festival',)
*/

-- Prediction Query
SELECT Festival_Name FROM festival_detail WHERE YEAR = 2007;

/*
Prediction Result:
('Zeta Festival',)
('Alpha Festival',)
('Alpha Festival',)
*/