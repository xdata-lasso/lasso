-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (1, 'USA', 330000000, 9833520, 'English');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (1, 1, 'Coaster A', 'Park 1', 200.0, 50.0, '60 mph', '2000', 'Operating');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (2, 1, 'Coaster B', 'Park 2', 100.0, 40.0, '50 mph', '2001', 'Operating');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LENGTH, height FROM roller_coaster ORDER BY LENGTH, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
(100.0, 40.0)
(200.0, 50.0)
*/

-- Prediction Query
SELECT LENGTH, Height FROM roller_coaster;

/*
Prediction Result:
(200.0, 50.0)
(100.0, 40.0)
*/