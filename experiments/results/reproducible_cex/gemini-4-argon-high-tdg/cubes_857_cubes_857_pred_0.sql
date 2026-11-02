-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'Zack', 180.5, 75.0, 'Austin');
INSERT INTO people ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (2, 'Alice', 165.0, 55.0, 'Boston');
INSERT INTO people ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (3, 'charlie', 175.0, 70.0, 'Chicago');
INSERT INTO people ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (4, 'Bob', 170.0, 68.0, 'Denver');
INSERT INTO perpetrator ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (2, 4, '2018-06-15', 2018.0, 'Downtown', 'USA', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zack',)
('charlie',)
*/

-- Prediction Query
SELECT Name FROM people WHERE NOT People_ID IN (SELECT People_ID FROM perpetrator);

/*
Prediction Result:
('Zack',)
('Alice',)
('charlie',)
*/