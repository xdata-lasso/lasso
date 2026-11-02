-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'John Doe', 180.0, 75.0, 'City A');
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (1, 1, '2020-01-01', 2020.0, 'Loc A', 'Country A', 10, 5);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (2, 1, '2021-01-01', 2021.0, 'Loc B', 'Country B', 20, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM perpetrator ORDER BY date, perpetrator.perpetrator_id NULLS LAST;

/*
Gold Result:
('2020-01-01',)
('2021-01-01',)
*/

-- Prediction Query
SELECT Date FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST;

/*
Prediction Result:
('2021-01-01',)
('2020-01-01',)
*/