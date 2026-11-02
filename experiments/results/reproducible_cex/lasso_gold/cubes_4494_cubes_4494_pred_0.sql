-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1008, 'Jamie Arnold', 'Lisa Hensley', '34131 Ramirez Roads
Franciscostad, IL 88342', 1009, 1010);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1011, 'Timothy Wong', 'Carolyn Daniel', '8350 Lydia Valley Suite 641
New Nancy, MD 28370', 1012, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT festival_id, LOCATION, MAX(num_of_audience) AS num_of_audience FROM festival_detail GROUP BY festival_id, LOCATION) ORDER BY LOCATION;

/*
Gold Result:
('34131 Ramirez Roads\nFranciscostad, IL 88342',)
('8350 Lydia Valley Suite 641\nNew Nancy, MD 28370',)
*/

-- Prediction Query
SELECT LOCATION FROM festival_detail ORDER BY Num_of_Audience DESC, festival_detail.festival_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('34131 Ramirez Roads\nFranciscostad, IL 88342',)
*/