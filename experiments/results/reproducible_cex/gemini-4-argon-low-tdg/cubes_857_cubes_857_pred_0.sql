-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'Zoe', 165.0, 60.0, 'Boston');
INSERT INTO people ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (2, 'Alice', 170.0, 65.0, 'Austin');
INSERT INTO people ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (3, 'Alice', 160.0, 55.0, 'Chicago');
INSERT INTO people ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (4, 'Bob', 180.0, 80.0, 'Denver');
INSERT INTO perpetrator ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (1, 4, '2020-01-01', 2020.0, 'Mall', 'USA', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT Name FROM people WHERE NOT People_ID IN (SELECT People_ID FROM perpetrator);

/*
Prediction Result:
('Zoe',)
('Alice',)
('Alice',)
*/