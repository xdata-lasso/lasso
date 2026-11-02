-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, "home town") VALUES (1, NULL, 0.0, 1.0, 'default1'), (0, NULL, 1.0, 0.0, NULL), (2, 'default2', 1.0, 0.0, 'default2');
INSERT INTO perpetrator (perpetrator_id, people_id, date, year, location, country, killed, injured) VALUES (0, NULL, NULL, NULL, 'default2', 'default2', 0, 1), (1, NULL, 'default2', 0.0, 'default1', NULL, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM perpetrator ORDER BY date, perpetrator.perpetrator_id NULLS LAST;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT Date FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST;

/*
Prediction Result:
('default2',)
(None,)
*/