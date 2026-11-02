-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'B', 180.0, 75.0, 'City1');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (2, 'A', 170.0, 65.0, 'City2');
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (1, 1, '2020-01-01', 2020.0, 'Loc1', 'Country1', 1, 1);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (2, 1, '2021-01-01', 2021.0, 'Loc2', 'Country1', 1, 1);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (3, 2, '2000-01-01', 2000.0, 'Loc3', 'Country2', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Year DESC, T1.people_id NULLS LAST, T2.perpetrator_id NULLS LAST;

/*
Prediction Result:
('B',)
('B',)
('A',)
*/