-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (1, 'Spain', 47000000, 505990, 'Spanish');
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (2, 'Germany', 83000000, 357022, 'German');
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (3, 'France', 67000000, 643801, 'French');
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (4, 'Brazil', 212000000, 8515767, 'Portuguese');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (101, 1, 'Shambhala', 'PortAventura', 1564.0, 76.0, '134 km/h', '2012', 'Operating');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (102, 1, 'Red Force', 'Ferrari Land', 880.0, 112.0, '180 km/h', '2017', 'Operating');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (103, 2, 'Silver Star', 'Europa-Park', 1620.0, 73.0, '127 km/h', '2002', 'Operating');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (104, 4, 'Montezum', 'Hopi Hari', 1030.0, 42.4, '103 km/h', '1999', 'Operating');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "country" WHERE ("languages" <> 'German') ORDER BY name, country.country_id NULLS LAST;

/*
Gold Result:
('Brazil',)
('France',)
('Spain',)
*/

-- Prediction Query
SELECT Name FROM country WHERE Languages <> 'German';

/*
Prediction Result:
('Spain',)
('France',)
('Brazil',)
*/