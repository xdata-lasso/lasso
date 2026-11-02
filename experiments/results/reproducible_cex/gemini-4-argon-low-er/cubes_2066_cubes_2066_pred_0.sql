-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (1, 'USA', 300000000, 9800000, 'English');
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (2, 'Japan', 125000000, 377000, 'Japanese');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (1, 1, 'Coaster A', 'Park A', 5000.0, 200.0, '100 mph', '2000', 'Operating');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (2, 2, 'Coaster B', 'Park B', 3000.0, 150.0, '80 mph', '2005', 'Operating');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT speed FROM (SELECT * FROM (SELECT * FROM roller_coaster ORDER BY country_id DESC, roller_coaster.roller_coaster_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('80 mph',)
*/

-- Prediction Query
SELECT Speed FROM roller_coaster ORDER BY LENGTH DESC, roller_coaster.roller_coaster_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('100 mph',)
*/