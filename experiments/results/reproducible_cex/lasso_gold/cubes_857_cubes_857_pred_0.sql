-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1029, 'Tommy Walter', 1030.5, 1031.5, 'Lake Mark');
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1032, 'James Mayo', 1031.5, 1032.5, 'Richardland');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('James Mayo',)
('Tommy Walter',)
*/

-- Prediction Query
SELECT Name FROM people WHERE NOT People_ID IN (SELECT People_ID FROM perpetrator);

/*
Prediction Result:
('Tommy Walter',)
('James Mayo',)
*/