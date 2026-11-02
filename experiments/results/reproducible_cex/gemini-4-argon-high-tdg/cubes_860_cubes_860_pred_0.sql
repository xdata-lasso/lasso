-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'Charlie', 180.5, 75.0, 'Boston');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (2, 'Zack', 175.0, 80.2, 'Austin');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (3, 'Alice', 165.0, 60.0, 'Denver');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (4, 'Bob', 170.0, 70.0, 'Chicago');
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (1, 2, '2020-01-01', 2020.0, 'Mall', 'USA', 4, 10);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (2, 2, '2021-05-10', 2021.0, 'Park', 'USA', 2, 5);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (5, 3, '2019-03-15', 2019.0, 'Bank', 'UK', 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Year DESC, T1.people_id NULLS LAST, T2.perpetrator_id NULLS LAST;

/*
Prediction Result:
('Zack',)
('Zack',)
('Alice',)
*/