-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1026, 'Lisa Archer', 'Alexandra Howell', '169 Donovan Ford
Johnfurt, DC 88540', 2007, 1027);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1028, 'Barry Hensley', 'Todd Hudson', '83842 Ibarra Gardens
Justinmouth, MP 71701', 2007, 1028);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT festival_name FROM festival_detail WHERE (YEAR = 2007) ORDER BY festival_name, festival_detail.festival_id NULLS LAST;

/*
Gold Result:
('Barry Hensley',)
('Lisa Archer',)
*/

-- Prediction Query
SELECT Festival_Name FROM festival_detail WHERE YEAR = 2007;

/*
Prediction Result:
('Lisa Archer',)
('Barry Hensley',)
*/