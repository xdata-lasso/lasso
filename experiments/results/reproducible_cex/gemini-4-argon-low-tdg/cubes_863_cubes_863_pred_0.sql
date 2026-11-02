-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL values in Name, empty strings, and NULL in the PRIMARY KEY (allowed in SQLite INTEGER PRIMARY KEY) to test NULLS LAST and secondary ordering.
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (10, 'Zack', 190.0, 95.0, 'Austin');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (5, NULL, 160.0, 50.0, 'Miami');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (2, '', 168.0, 55.0, 'Denver');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'Aaron', 172.0, 68.0, 'Dallas');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (8, NULL, 182.0, 80.0, 'Phoenix');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('',)
('Aaron',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM People ORDER BY Height ASC, People.people_id NULLS LAST;

/*
Prediction Result:
(None,)
('',)
('Aaron',)
(None,)
('Zack',)
*/