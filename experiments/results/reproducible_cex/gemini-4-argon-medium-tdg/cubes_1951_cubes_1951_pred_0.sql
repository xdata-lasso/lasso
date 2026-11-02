-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests WHERE boundaries (2007, 2008, 2009, 2010, 2011, NULL), ORDER BY direction (ASC vs DESC), and duplicate handling (SELECT vs SELECT DISTINCT)
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (1, 'F1', 'C1', 'L1', 2007, 100);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (2, 'F2', 'C2', 'L2', 2008, 500);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (3, 'F3', 'C3', 'L3', 2009, 300);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (4, 'F4', 'C4', 'L4', 2010, 300);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (5, 'F5', 'C5', 'L5', 2011, 200);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (6, 'F6', 'C6', 'L6', NULL, 400);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT num_of_audience FROM festival_detail WHERE (YEAR >= 2008 OR YEAR > 2010) ORDER BY num_of_audience, festival_detail.festival_id NULLS LAST;

/*
Gold Result:
(200,)
(300,)
(300,)
(500,)
*/

-- Prediction Query
SELECT Num_of_Audience FROM festival_detail WHERE YEAR = 2008 OR YEAR = 2010;

/*
Prediction Result:
(500,)
(300,)
*/