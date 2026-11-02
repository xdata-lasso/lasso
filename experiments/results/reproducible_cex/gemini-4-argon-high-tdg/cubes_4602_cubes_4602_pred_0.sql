-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (1, 'USA', 331000000, 9833520, 'English');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (2, 'Germany', 83000000, 357022, 'German');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (1, 1, 'Alpha Coaster', 'Zebra Gardens', 1200.0, 45.0, '85', '2010', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (2, 1, 'Beta Coaster', 'Acorn Valley', 2500.0, 95.0, '60', '2012', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (3, 2, 'Gamma Coaster', 'Beacon Hills', 900.0, 30.0, '70', '2005', 'Closed');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (4, 2, 'Delta Coaster', 'Meadow Park', 1800.0, 80.0, '50', '1999', 'Closed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT park FROM (SELECT LHS.roller_coaster_id AS roller_coaster_id, LHS.name AS name, LHS.park AS park, LHS.country_id AS country_id, LHS.length AS LENGTH, LHS.height AS height, LHS.speed AS speed, LHS.opened AS opened, LHS.status AS status, RHS.status AS status_other, RHS.speed AS speed_other FROM roller_coaster AS LHS CROSS JOIN (SELECT status, MAX(speed) AS speed FROM roller_coaster GROUP BY status) AS RHS) WHERE (speed = speed_other) ORDER BY park;

/*
Gold Result:
('Beacon Hills',)
('Zebra Gardens',)
*/

-- Prediction Query
SELECT Park FROM roller_coaster ORDER BY Speed DESC, roller_coaster.roller_coaster_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zebra Gardens',)
*/