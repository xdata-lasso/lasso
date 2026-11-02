-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, "home town") VALUES (1, 'default2', NULL, 1.0, 'default2');
INSERT INTO perpetrator (perpetrator_id, people_id, date, year, location, country, killed, injured) VALUES (1, 1, 'default2', 1.0, 'default2', 'default1', NULL, NULL), (0, 1, 'default2', 1.0, 'default1', NULL, 0, 0), (2, 1, 'default2', 0.0, 'default1', 'default2', 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT height FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY height;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.Height FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Injured DESC, T1.people_id NULLS LAST, T2.perpetrator_id NULLS LAST;

/*
Prediction Result:
(None,)
(None,)
(None,)
*/