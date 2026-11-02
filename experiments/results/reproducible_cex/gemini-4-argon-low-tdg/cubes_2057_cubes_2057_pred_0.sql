-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inequality filter (<> 'German'), ORDER BY Name ASC, and JOIN vs single-table mutants (via countries with 0, 1, and multiple roller coasters).
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (1, 'Germany', 83000000, 357022, 'German');
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (2, 'France', 67000000, 640679, 'French');
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (3, 'Brazil', 212000000, 8515767, 'Portuguese');
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (4, 'Japan', 125000000, 377975, 'Japanese');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (101, 1, 'Silver Star', 'Europa-Park', 1620.0, 73.0, '130 km/h', '2002', 'Operating');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (102, 2, 'Toutatis', 'Parc Asterix', 1075.0, 51.0, '107 km/h', '2023', 'Operating');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (103, 2, 'OzIris', 'Parc Asterix', 1000.0, 40.0, '90 km/h', '2012', 'Operating');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "country" WHERE ("languages" <> 'German') ORDER BY name, country.country_id NULLS LAST;

/*
Gold Result:
('Brazil',)
('France',)
('Japan',)
*/

-- Prediction Query
SELECT Name FROM country WHERE Languages <> 'German';

/*
Prediction Result:
('France',)
('Brazil',)
('Japan',)
*/