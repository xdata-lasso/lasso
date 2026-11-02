-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: festival_detail --
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1, '5k5swwqcgs', '9n8', 'fes_b0afb8', 1610062532, -106629402);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483647, 'u7', 'fe4hri', NULL, 1914020640, 1268590800);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT festival_id, LOCATION, MAX(num_of_audience) AS num_of_audience FROM festival_detail GROUP BY festival_id, LOCATION) ORDER BY LOCATION;

/*
Gold Result:
(None,)
('fes_b0afb8',)
*/

-- Prediction Query
SELECT LOCATION FROM festival_detail ORDER BY Num_of_Audience DESC, festival_detail.festival_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/