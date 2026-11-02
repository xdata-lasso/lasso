-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO festival_detail (festival_id, festival_name, chair_name, location, year, num_of_audience) VALUES (2007, NULL, 'default1', 'default1', 0, 2011), (1, 'default1', 'default1', 'default1', 2009, 2010), (2011, 'default1', 'default1', NULL, 2010, 0), (2008, 'default2', NULL, 'default2', 2008, 2011), (2009, 'default1', 'default1', 'default2', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT num_of_audience FROM festival_detail WHERE (YEAR >= 2008 OR YEAR > 2010) ORDER BY num_of_audience, festival_detail.festival_id NULLS LAST;

/*
Gold Result:
(0,)
(2010,)
(2011,)
*/

-- Prediction Query
SELECT Num_of_Audience FROM festival_detail WHERE YEAR = 2008 OR YEAR = 2010;

/*
Prediction Result:
(2011,)
(0,)
*/