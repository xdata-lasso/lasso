-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (8, '11', '11', '11', 11, NULL);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (7, '11', '11', '11', 11, -719);
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (10, '11', '11');
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (9, '11', '11');
INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (9, 8, '11');
INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (10, 7, '11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT festival_id, LOCATION, MAX(num_of_audience) AS num_of_audience FROM festival_detail GROUP BY festival_id, LOCATION) ORDER BY LOCATION;

/*
Gold Result:
('11',)
*/

-- Prediction Query
SELECT LOCATION FROM festival_detail ORDER BY Num_of_Audience DESC, festival_detail.festival_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('11',)
*/