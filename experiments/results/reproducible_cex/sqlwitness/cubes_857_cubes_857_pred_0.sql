-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, "home town") VALUES (0, NULL, 0.0, 1.0, NULL), (2, 'default2', 1.0, 2.0, 'default2'), (1, 'default1', 1.0, NULL, NULL), (3, 'default1', 2.0, 0.0, NULL), (4, 'default2', 2.0, 0.0, NULL), (5, 'default1', 1.0, 2.0, NULL), (6, 'default2', 1.0, 1.0, 'default1');
INSERT INTO perpetrator (perpetrator_id, people_id, date, year, location, country, killed, injured) VALUES (0, 2, 'default2', 1.0, NULL, 'default2', 1, NULL), (2, 5, 'default1', 0.0, 'default2', NULL, NULL, 1), (1, NULL, NULL, 0.0, NULL, NULL, 1, 0), (3, 0, 'default1', 0.0, 'default1', 'default2', NULL, 0), (4, 4, 'default1', NULL, 'default2', NULL, 1, 0), (5, 6, 'default2', 1.0, 'default2', 'default1', 1, 1), (6, 2, 'default1', NULL, NULL, 'default1', 2, 1), (7, 6, NULL, 2.0, 'default2', 'default2', 2, 2), (8, 5, 'default1', 2.0, 'default2', NULL, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('default1',)
('default1',)
*/

-- Prediction Query
SELECT Name FROM people WHERE NOT People_ID IN (SELECT People_ID FROM perpetrator);

/*
Prediction Result:
*/