-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'Alice Smith', 165.0, 60.0, 'New York');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (2, 'Bob Jones', 180.0, 80.0, 'Chicago');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (3, 'Charlie Brown', 175.0, 72.0, 'Boston');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (4, 'David Clark', 170.0, 68.0, 'Seattle');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (5, 'Eve Davis', 160.0, 55.0, 'Miami');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (6, 'Frank Miller', 185.0, 90.0, 'Denver');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (7, 'Grace Wilson', 168.0, 62.0, 'Austin');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (8, 'Henry Moore', 178.0, 76.0, 'Dallas');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (9, 'Ivy Taylor', 162.0, 58.0, 'Phoenix');
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (1, 2, '2001-04-10', 2001.0, 'Paris', 'France', 2, 5);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (2, 3, '2002-06-15', 2002.0, 'Paris', 'France', 1, 3);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (3, 4, '2003-08-20', 2003.0, 'London', 'UK', 0, 4);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (4, 5, '2004-01-12', 2004.0, 'Berlin', 'Germany', 3, 1);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (5, 8, '2005-09-01', 2005.0, 'Rome', 'Italy', 2, 2);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (6, 9, '2006-11-30', 2006.0, 'Rome', 'Italy', 4, 0);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (7, 8, '2007-03-22', 2007.0, 'Athens', 'Greece', 1, 6);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (8, 9, '2008-07-14', 2008.0, 'Athens', 'Greece', 5, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.perpetrator_id AS perpetrator_id, LHS.people_id AS people_id, LHS.date AS date, LHS.year AS YEAR, LHS.location AS LOCATION, LHS.country AS country, LHS.killed AS killed, LHS.injured AS injured, RHS.people_id AS people_id_other, RHS.date AS date_other, RHS.year AS year_other, RHS.country AS country_other, RHS.killed AS killed_other, RHS.injured AS injured_other FROM perpetrator AS LHS INNER JOIN perpetrator AS RHS ON (LHS.people_id = RHS.perpetrator_id AND LHS.location = RHS.location)) ORDER BY LOCATION;

/*
Gold Result:
('Athens',)
('Paris',)
*/

-- Prediction Query
SELECT LOCATION FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Athens',)
*/