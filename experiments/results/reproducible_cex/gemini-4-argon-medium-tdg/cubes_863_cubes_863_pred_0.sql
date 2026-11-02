-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (3, 'Alice', 160.0, 55.0, 'Berlin');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'alice', 170.0, 65.0, 'Munich');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (2, 'Bob', 185.0, 85.0, 'Hamburg');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (4, '', 150.0, 45.0, 'Cologne');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
('',)
('Alice',)
('Bob',)
('alice',)
*/

-- Prediction Query
SELECT Name FROM People ORDER BY Height ASC, People.people_id NULLS LAST;

/*
Prediction Result:
('',)
('Alice',)
('alice',)
('Bob',)
*/