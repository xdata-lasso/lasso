-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'Alice Smith', 170.5, 65.0, 'New York');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (2, 'Bob Jones', 180.0, 80.5, 'Los Angeles');
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (10, 1, '2020-12-01', 2020.0, 'Downtown', 'USA', 2, 5);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (5, 2, '2018-05-15', 2018.0, 'Suburb', 'USA', 0, 1);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (20, 1, '2019-01-10', 2019.0, 'Station', 'Canada', 1, 0);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (1, 2, '2019-01-10', 2019.0, 'Airport', 'Mexico', 3, 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM perpetrator ORDER BY date, perpetrator.perpetrator_id NULLS LAST;

/*
Gold Result:
('2018-05-15',)
('2019-01-10',)
('2019-01-10',)
('2020-12-01',)
*/

-- Prediction Query
SELECT Date FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST;

/*
Prediction Result:
('2019-01-10',)
('2020-12-01',)
('2019-01-10',)
('2018-05-15',)
*/