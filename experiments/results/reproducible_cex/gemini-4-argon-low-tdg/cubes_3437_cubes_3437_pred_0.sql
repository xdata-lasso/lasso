-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'John Doe', 180.5, 75.0, 'New York');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (2, 'Jane Smith', 165.0, 60.0, 'London');
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (1, 1, '2020-01-01', 2020.0, 'Alpha City', 'USA', 10, 5);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (2, 1, '2020-02-01', 2020.0, 'Alpha City', 'USA', 10, 2);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (3, 2, '2021-01-01', 2021.0, 'Beta Town', 'UK', 5, 20);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (4, 2, '2021-03-01', 2021.0, 'Gamma Village', 'UK', 10, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT LHS.perpetrator_id AS perpetrator_id, LHS.people_id AS people_id, LHS.date AS date, LHS.year AS YEAR, LHS.location AS LOCATION, LHS.country AS country, LHS.killed AS killed, LHS.injured AS injured, LHS.maxkilled AS maxkilled, RHS.perpetrator_id AS perpetrator_id_other, RHS.people_id AS people_id_other, RHS.date AS date_other, RHS.year AS year_other, RHS.location AS location_other, RHS.country AS country_other, RHS.killed AS killed_other, RHS.injured AS injured_other, RHS.maxkilled AS maxkilled_other FROM (SELECT perpetrator_id, people_id, date, YEAR, LOCATION, country, killed, injured, MAX(killed) OVER () AS maxkilled FROM perpetrator) AS LHS CROSS JOIN (SELECT perpetrator_id, people_id, date, YEAR, LOCATION, country, killed, injured, MAX(killed) OVER () AS maxkilled FROM perpetrator) AS RHS) WHERE (killed >= maxkilled_other OR maxkilled <> maxkilled_other) ORDER BY LOCATION;

/*
Gold Result:
('Alpha City',)
('Gamma Village',)
*/

-- Prediction Query
SELECT LOCATION FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha City',)
*/