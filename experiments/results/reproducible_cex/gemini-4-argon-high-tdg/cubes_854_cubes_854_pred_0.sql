-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Height, Weight, "Home Town") VALUES (1, 'John Doe', 180.5, 75.0, 'Toronto');
INSERT INTO people (People_ID, Name, Height, Weight, "Home Town") VALUES (2, 'Jane Roe', 165.0, 60.2, 'Sao Paulo');
INSERT INTO people (People_ID, Name, Height, Weight, "Home Town") VALUES (3, 'Carlos Ruiz', 175.0, 80.0, 'Buenos Aires');
INSERT INTO perpetrator (Perpetrator_ID, People_ID, Date, Year, Location, Country, Killed, Injured) VALUES (1, 1, '2001-05-10', 2001.0, 'Montreal', 'Canada', 2, 50);
INSERT INTO perpetrator (Perpetrator_ID, People_ID, Date, Year, Location, Country, Killed, Injured) VALUES (2, 2, '2002-06-15', 2002.0, 'Rio', 'Brazil', 10, 49);
INSERT INTO perpetrator (Perpetrator_ID, People_ID, Date, Year, Location, Country, Killed, Injured) VALUES (3, 3, '2003-07-20', 2003.0, 'Cordoba', 'Argentina', 5, 51);
INSERT INTO perpetrator (Perpetrator_ID, People_ID, Date, Year, Location, Country, Killed, Injured) VALUES (4, 1, '2004-08-25', 2004.0, 'Copenhagen', 'Denmark', 1, 21);
INSERT INTO perpetrator (Perpetrator_ID, People_ID, Date, Year, Location, Country, Killed, Injured) VALUES (5, 2, '2005-09-30', 2005.0, 'Cairo', 'Egypt', 0, 20);
INSERT INTO perpetrator (Perpetrator_ID, People_ID, Date, Year, Location, Country, Killed, Injured) VALUES (6, 3, '2006-10-05', 2006.0, 'Paris', 'France', 100, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM perpetrator WHERE (injured >= 50 AND injured > 20) ORDER BY country, perpetrator.perpetrator_id NULLS LAST;

/*
Gold Result:
('Argentina',)
('Canada',)
*/

-- Prediction Query
SELECT Country FROM perpetrator WHERE Injured > 50 INTERSECT SELECT Country FROM perpetrator WHERE Injured < 20;

/*
Prediction Result:
*/