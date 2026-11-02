-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties for maximum Killed (both same and different Locations), non-max rows, DISTINCT deduplication, and ORDER BY Location.
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'Alice', 170.0, 65.0, 'New York');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (2, 'Bob', 180.0, 80.0, 'London');
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (1, 1, '2020-01-01', 2020.0, 'Tokyo', 'Japan', 50, 10);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (2, 1, '2020-02-01', 2020.0, 'Berlin', 'Germany', 50, 100);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (3, 2, '2020-03-01', 2020.0, 'Berlin', 'Germany', 50, 5);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (4, 2, '2020-04-01', 2020.0, 'Paris', 'France', 20, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT LHS.perpetrator_id AS perpetrator_id, LHS.people_id AS people_id, LHS.date AS date, LHS.year AS YEAR, LHS.location AS LOCATION, LHS.country AS country, LHS.killed AS killed, LHS.injured AS injured, LHS.maxkilled AS maxkilled, RHS.perpetrator_id AS perpetrator_id_other, RHS.people_id AS people_id_other, RHS.date AS date_other, RHS.year AS year_other, RHS.location AS location_other, RHS.country AS country_other, RHS.killed AS killed_other, RHS.injured AS injured_other, RHS.maxkilled AS maxkilled_other FROM (SELECT perpetrator_id, people_id, date, YEAR, LOCATION, country, killed, injured, MAX(killed) OVER () AS maxkilled FROM perpetrator) AS LHS CROSS JOIN (SELECT perpetrator_id, people_id, date, YEAR, LOCATION, country, killed, injured, MAX(killed) OVER () AS maxkilled FROM perpetrator) AS RHS) WHERE (killed >= maxkilled_other OR maxkilled <> maxkilled_other) ORDER BY LOCATION;

/*
Gold Result:
('Berlin',)
('Tokyo',)
*/

-- Prediction Query
SELECT LOCATION FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Tokyo',)
*/