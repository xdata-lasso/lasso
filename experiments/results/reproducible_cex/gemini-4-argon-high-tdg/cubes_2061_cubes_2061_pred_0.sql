-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (1, 'United States', 331000000, 9833520, 'English');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (2, 'Germany', 83000000, 357022, 'German');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (1, 1, 'Zumanjaro', 'Six Flags Great Adventure', 1260.0, 415.0, '90 mph', '2014', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (2, 1, 'Alpengeist', 'Busch Gardens Williamsburg', 3828.0, 195.0, '67 mph', '1997', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (3, 2, 'Silver Star', 'Europa-Park', 5315.0, 239.5, '78.9 mph', '2002', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (4, 1, 'Alpengeist', 'Six Flags Magic Mountain', 3200.0, 150.0, '60 mph', '2005', 'Operating');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM roller_coaster ORDER BY name, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
('Alpengeist',)
('Alpengeist',)
('Silver Star',)
('Zumanjaro',)
*/

-- Prediction Query
SELECT Name FROM roller_coaster ORDER BY LENGTH ASC, roller_coaster.roller_coaster_id NULLS LAST;

/*
Prediction Result:
('Zumanjaro',)
('Alpengeist',)
('Alpengeist',)
('Silver Star',)
*/