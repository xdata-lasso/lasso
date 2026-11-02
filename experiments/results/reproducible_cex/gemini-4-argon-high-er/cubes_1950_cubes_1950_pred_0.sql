-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (1, 'Painting', 'Sunflowers');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM(num_of_audience) OVER () AS sum_num_of_audience_ FROM festival_detail ORDER BY sum_num_of_audience_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(Num_of_Audience) FROM festival_detail;

/*
Prediction Result:
(None,)
*/