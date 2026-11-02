-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests anti-correlation between Roller_Coaster_ID and Name (to catch mutants that only order by ID or order DESC),
-- and case sensitivity / special characters in Name.
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (100, NULL, 'Alpha', 'Park Z', 500.0, 20.0, '50', '1999', 'Removed');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (50, NULL, 'Beta', 'Park Y', 600.0, 30.0, '60', '2000', 'Operating');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (10, NULL, 'alpha', 'Park X', 700.0, 40.0, '70', '2001', 'Under Construction');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (1, NULL, 'Zeta', 'Park A', 800.0, 50.0, '80', '2002', 'Operating');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM roller_coaster ORDER BY name, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Beta',)
('Zeta',)
('alpha',)
*/

-- Prediction Query
SELECT Name FROM roller_coaster ORDER BY LENGTH ASC, roller_coaster.roller_coaster_id NULLS LAST;

/*
Prediction Result:
('Alpha',)
('Beta',)
('alpha',)
('Zeta',)
*/