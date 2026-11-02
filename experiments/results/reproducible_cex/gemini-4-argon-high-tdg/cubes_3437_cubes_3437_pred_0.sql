-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO people (People_ID, Name, Height, Weight, "Home Town") VALUES (1, 'Person One', 175.0, 70.0, 'HomeA');
INSERT INTO people (People_ID, Name, Height, Weight, "Home Town") VALUES (2, 'Person Two', 168.0, 62.0, 'HomeB');
INSERT INTO people (People_ID, Name, Height, Weight, "Home Town") VALUES (3, 'Person Three', 182.0, 85.0, 'HomeC');
INSERT INTO people (People_ID, Name, Height, Weight, "Home Town") VALUES (4, 'Person Four', 160.0, 55.0, 'HomeD');
INSERT INTO perpetrator (Perpetrator_ID, People_ID, Date, Year, Location, Country, Killed, Injured) VALUES (1, 1, '2010-01-01', 2010.0, 'Zurich', 'Switzerland', 40, 5);
INSERT INTO perpetrator (Perpetrator_ID, People_ID, Date, Year, Location, Country, Killed, Injured) VALUES (2, 2, '2011-02-02', 2011.0, 'Madrid', 'Spain', 40, 20);
INSERT INTO perpetrator (Perpetrator_ID, People_ID, Date, Year, Location, Country, Killed, Injured) VALUES (3, 3, '2012-03-03', 2012.0, 'Berlin', 'Germany', 40, 15);
INSERT INTO perpetrator (Perpetrator_ID, People_ID, Date, Year, Location, Country, Killed, Injured) VALUES (4, 4, '2013-04-04', 2013.0, 'Athens', 'Greece', 10, 99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT LHS.perpetrator_id AS perpetrator_id, LHS.people_id AS people_id, LHS.date AS date, LHS.year AS YEAR, LHS.location AS LOCATION, LHS.country AS country, LHS.killed AS killed, LHS.injured AS injured, LHS.maxkilled AS maxkilled, RHS.perpetrator_id AS perpetrator_id_other, RHS.people_id AS people_id_other, RHS.date AS date_other, RHS.year AS year_other, RHS.location AS location_other, RHS.country AS country_other, RHS.killed AS killed_other, RHS.injured AS injured_other, RHS.maxkilled AS maxkilled_other FROM (SELECT perpetrator_id, people_id, date, YEAR, LOCATION, country, killed, injured, MAX(killed) OVER () AS maxkilled FROM perpetrator) AS LHS CROSS JOIN (SELECT perpetrator_id, people_id, date, YEAR, LOCATION, country, killed, injured, MAX(killed) OVER () AS maxkilled FROM perpetrator) AS RHS) WHERE (killed >= maxkilled_other OR maxkilled <> maxkilled_other) ORDER BY LOCATION;

/*
Gold Result:
('Berlin',)
('Madrid',)
('Zurich',)
*/

-- Prediction Query
SELECT LOCATION FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zurich',)
*/