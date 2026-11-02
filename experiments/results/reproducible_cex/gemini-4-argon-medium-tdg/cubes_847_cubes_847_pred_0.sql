-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'Alice', 170.0, 65.0, 'TownA');
INSERT INTO people ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (2, 'Bob', 180.0, 75.0, 'TownB');
INSERT INTO people ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (3, 'Charlie', 160.0, 55.0, 'TownC');
INSERT INTO perpetrator ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (1, 2, '2020-01-01', 2020.0, 'Boston', 'USA', 1, 2);
INSERT INTO perpetrator ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (2, 3, '2021-02-02', 2021.0, 'Boston', 'Canada', 0, 5);
INSERT INTO perpetrator ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (3, 3, '2019-03-03', 2019.0, 'Atlanta', 'USA', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.perpetrator_id AS perpetrator_id, LHS.people_id AS people_id, LHS.date AS date, LHS.year AS YEAR, LHS.location AS LOCATION, LHS.country AS country, LHS.killed AS killed, LHS.injured AS injured, RHS.people_id AS people_id_other, RHS.date AS date_other, RHS.year AS year_other, RHS.country AS country_other, RHS.killed AS killed_other, RHS.injured AS injured_other FROM perpetrator AS LHS INNER JOIN perpetrator AS RHS ON (LHS.people_id = RHS.perpetrator_id AND LHS.location = RHS.location)) ORDER BY LOCATION;

/*
Gold Result:
('Atlanta',)
('Boston',)
*/

-- Prediction Query
SELECT LOCATION FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Atlanta',)
*/