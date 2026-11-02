-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Comprehensive dataset testing:
-- 1. 1-to-N relationship (Person 1 has two perpetrator records -> kills INNER JOIN without DISTINCT)
-- 2. Unmatched people (Person 2 has no perpetrator records -> kills missing WHERE/JOIN or LEFT JOIN)
-- 3. Duplicate heights across different people (Person 1 and Person 3 both have Height 175.5 -> kills SELECT DISTINCT height)
-- 4. Unordered insertion and decimal values (Person 4 has Height 160.2 -> kills missing ORDER BY, ORDER BY DESC, or Weight vs Height confusion)
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'Alice', 175.5, 70.0, 'New York');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (2, 'Bob', 180.0, 85.0, 'Los Angeles');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (3, 'Charlie', 175.5, 65.0, 'Chicago');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (4, 'David', 160.2, 90.0, 'Houston');
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (101, 1, '2020-01-01', 2020.0, 'Loc A', 'USA', 0, 1);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (102, 1, '2021-05-12', 2021.0, 'Loc B', 'USA', 1, 2);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (103, 3, '2019-11-20', 2019.0, 'Loc C', 'UK', 2, 0);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (104, 4, '2022-03-15', 2022.0, 'Loc D', 'Canada', 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT height FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY height;

/*
Gold Result:
(160.2,)
(175.5,)
(175.5,)
*/

-- Prediction Query
SELECT T1.Height FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Injured DESC, T1.people_id NULLS LAST, T2.perpetrator_id NULLS LAST;

/*
Prediction Result:
(175.5,)
(175.5,)
(175.5,)
(160.2,)
*/