-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (10, 'Austria', 9000000, 83879, 'German');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (20, 'Germany', 83000000, 357022, 'German');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (30, 'Finland', 5500000, 338424, 'Finnish');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (40, 'Belgium', 11500000, 30528, 'Dutch');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (1, 10, 'Alpha Coaster', 'Prater', 1200.0, 45.0, '50', '1995', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (2, 30, 'Beta Coaster', 'Linnanmaki', 950.0, 35.0, '65', '2005', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (3, 30, 'Gamma Coaster', 'Sarkanniemi', 1500.0, 60.0, '80', '2010', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (4, 20, 'Delta Coaster', 'Europa Park', 1800.0, 73.0, '100', '2018', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (5, 10, 'Epsilon Coaster', 'Prater', 800.0, 25.0, '90', '1988', 'Removed');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (6, 10, 'Zeta Coaster', 'Prater', 1100.0, 40.0, '70', '2001', 'Operating');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT speed FROM (SELECT * FROM (SELECT * FROM roller_coaster ORDER BY country_id DESC, roller_coaster.roller_coaster_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('65',)
*/

-- Prediction Query
SELECT Speed FROM roller_coaster ORDER BY LENGTH DESC, roller_coaster.roller_coaster_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('100',)
*/