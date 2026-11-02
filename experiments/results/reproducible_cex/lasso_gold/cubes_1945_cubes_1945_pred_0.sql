-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1001, 'Allison Hill', 'Cristian Santos', 'USNV Garcia
FPO AA 13177', 1005, 1009);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1002, 'Noah Rhodes', 'Connie Lawrence', '407 Teresa Lane Apt. 849
Barbaraland, AZ 87174', 1016.0, 1022.0);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1003, 'Angie Henderson', 'Abigail Shaffer', '31647 Martin Knoll Apt. 419
New Jessica, GA 61090', 1027.0, 1035.0);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1004, 'Daniel Wagner', 'Gina Moore', '503 Linda Locks
Carlshire, FM 94599', 1038.0, 1048.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT YEAR FROM (SELECT * FROM (SELECT * FROM (SELECT festival_id, festival_name, chair_name, LOCATION, YEAR, num_of_audience, COUNT(*) OVER () AS n FROM festival_detail) ORDER BY festival_name) LIMIT 1);

/*
Gold Result:
(1005,)
*/

-- Prediction Query
SELECT YEAR FROM festival_detail GROUP BY YEAR HAVING COUNT(*) > 1;

/*
Prediction Result:
*/