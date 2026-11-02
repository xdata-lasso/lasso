-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC), duplicate Date values (DISTINCT vs ALL), and NULLS FIRST vs NULLS LAST on Date.
INSERT INTO people (People_ID, Name, Height, Weight, "Home Town") VALUES (1, 'John Doe', 180.0, 75.0, 'New York');
INSERT INTO perpetrator (Perpetrator_ID, People_ID, Date, Year, Location, Country, Killed, Injured) VALUES (1, 1, '2020-05-01', 2020.0, 'NY', 'USA', 1, 2);
INSERT INTO perpetrator (Perpetrator_ID, People_ID, Date, Year, Location, Country, Killed, Injured) VALUES (2, 1, '2018-01-15', 2018.0, 'LA', 'USA', 0, 5);
INSERT INTO perpetrator (Perpetrator_ID, People_ID, Date, Year, Location, Country, Killed, Injured) VALUES (3, 1, '2018-01-15', 2018.0, 'SF', 'USA', 2, 0);
INSERT INTO perpetrator (Perpetrator_ID, People_ID, Date, Year, Location, Country, Killed, Injured) VALUES (4, 1, NULL, 2019.0, 'CHI', 'USA', 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM perpetrator ORDER BY date, perpetrator.perpetrator_id NULLS LAST;

/*
Gold Result:
(None,)
('2018-01-15',)
('2018-01-15',)
('2020-05-01',)
*/

-- Prediction Query
SELECT Date FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST;

/*
Prediction Result:
('2018-01-15',)
('2020-05-01',)
('2018-01-15',)
(None,)
*/