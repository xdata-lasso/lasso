-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1008, 'Jennifer Rocha', 'Carolyn Daniel', '34131 Ramirez Roads
Franciscostad, IL 88342', 1009, 1010);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1011, 'Jamie Arnold', 'Lisa Hensley', '8350 Lydia Valley Suite 641
New Nancy, MD 28370', 1010, 1011);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT festival_name, LOCATION FROM festival_detail ORDER BY festival_name, festival_detail.festival_id NULLS LAST;

/*
Gold Result:
('Jamie Arnold', '8350 Lydia Valley Suite 641\nNew Nancy, MD 28370')
('Jennifer Rocha', '34131 Ramirez Roads\nFranciscostad, IL 88342')
*/

-- Prediction Query
SELECT Festival_Name, LOCATION FROM festival_detail;

/*
Prediction Result:
('Jennifer Rocha', '34131 Ramirez Roads\nFranciscostad, IL 88342')
('Jamie Arnold', '8350 Lydia Valley Suite 641\nNew Nancy, MD 28370')
*/