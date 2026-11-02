-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1008, 'Kevin Pacheco', 'Madagascar', 'kind', 1009, 1010);
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1011, 'Allen Robinson', 'Mayotte', 'play', 1010, 1011);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM manager ORDER BY name, manager.manager_id NULLS LAST;

/*
Gold Result:
('Allen Robinson',)
('Kevin Pacheco',)
*/

-- Prediction Query
SELECT Name FROM manager ORDER BY LEVEL ASC, manager.manager_id NULLS LAST;

/*
Prediction Result:
('Kevin Pacheco',)
('Allen Robinson',)
*/