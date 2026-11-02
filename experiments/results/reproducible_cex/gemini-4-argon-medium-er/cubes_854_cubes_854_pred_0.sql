-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'John Doe', 180.0, 75.0, 'New York');
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (1, 1, '2020-01-01', 2020.0, 'City', 'USA', 0, 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM perpetrator WHERE (injured >= 50 AND injured > 20) ORDER BY country, perpetrator.perpetrator_id NULLS LAST;

/*
Gold Result:
('USA',)
*/

-- Prediction Query
SELECT Country FROM perpetrator WHERE Injured > 50 INTERSECT SELECT Country FROM perpetrator WHERE Injured < 20;

/*
Prediction Result:
*/