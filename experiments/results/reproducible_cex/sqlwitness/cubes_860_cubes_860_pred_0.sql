-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, "home town") VALUES (2, NULL, 2.0, 1.0, 'default1'), (1, NULL, 0.0, 0.0, 'default1'), (0, 'default2', NULL, 1.0, 'default2'), (3, 'default1', 0.0, 1.0, NULL);
INSERT INTO perpetrator (perpetrator_id, people_id, date, year, location, country, killed, injured) VALUES (2, 0, NULL, 2.0, 'default2', 'default1', 2, 2), (1, 2, 'default1', 1.0, NULL, 'default1', 2, 0), (0, 3, 'default1', 2.0, 'default2', NULL, 2, NULL), (3, NULL, 'default2', NULL, 'default2', NULL, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Year DESC, T1.people_id NULLS LAST, T2.perpetrator_id NULLS LAST;

/*
Prediction Result:
('default2',)
('default1',)
(None,)
*/