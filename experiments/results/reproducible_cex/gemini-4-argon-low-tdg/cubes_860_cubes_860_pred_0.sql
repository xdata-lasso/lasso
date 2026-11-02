-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests 1-to-Many relationship (EXISTS vs INNER JOIN without DISTINCT) and duplicate names across different people (SELECT Name vs SELECT DISTINCT Name).
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (10, 'Charlie', 175.0, 70.0, 'New York');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (20, 'David', 182.0, 80.0, 'Chicago');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (30, 'David', 168.0, 62.0, 'Boston');
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (101, 10, '1999-12-31', 1999.0, 'Manhattan', 'USA', 2, 0);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (102, 10, '2001-06-15', 2001.0, 'Queens', 'USA', 0, 1);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (103, 20, '2015-03-20', 2015.0, 'Loop', 'USA', 1, 1);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (104, 30, '2018-09-10', 2018.0, 'Back Bay', 'USA', 3, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('Charlie',)
('David',)
('David',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Year DESC, T1.people_id NULLS LAST, T2.perpetrator_id NULLS LAST;

/*
Prediction Result:
('David',)
('David',)
('Charlie',)
('Charlie',)
*/