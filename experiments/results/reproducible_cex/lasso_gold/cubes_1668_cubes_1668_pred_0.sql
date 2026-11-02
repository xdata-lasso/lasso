-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1012, 'Melissa Peterson', 'Cape Verde', 'dinner', 0, 1013);
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1014, 'Gabrielle Davis', 'Bhutan', 'her', -50, 1015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM manager WHERE (age > 50 OR age < 46) ORDER BY country, manager.manager_id NULLS LAST;

/*
Gold Result:
('Bhutan',)
('Cape Verde',)
*/

-- Prediction Query
SELECT Country FROM manager WHERE Age > 50 OR Age < 46;

/*
Prediction Result:
('Cape Verde',)
('Bhutan',)
*/