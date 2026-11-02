-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (1, 'USA', 331000000, 9833520, 'English');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (2, 'UK', 67000000, 242495, 'English');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (10, 1, 'Viper', 'Six Flags', 3830.0, 188.0, '70 mph', '1990', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (20, 1, 'Goliath', 'Six Flags', 4500.0, 235.0, '85 mph', '2000', 'Closed');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (30, 2, 'Viper', 'Alton Towers', 2500.0, 100.0, '50 mph', '1995', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (40, NULL, 'Behemoth', 'Wonderland', 5318.0, 230.0, '77 mph', '2008', 'Operating');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM roller_coaster ORDER BY name, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
('Behemoth',)
('Goliath',)
('Viper',)
('Viper',)
*/

-- Prediction Query
SELECT Name FROM roller_coaster ORDER BY LENGTH ASC, roller_coaster.roller_coaster_id NULLS LAST;

/*
Prediction Result:
('Viper',)
('Viper',)
('Goliath',)
('Behemoth',)
*/