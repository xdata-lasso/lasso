-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1001, 'Allison Hill', 'Anguilla', 'rate', 1005, 1009);
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1002, 'Noah Rhodes', 'Monaco', 'science', 1016.0, 1022.0);
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1003, 'Angie Henderson', 'Congo', 'offer', 1027.0, 1035.0);
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1004, 'Daniel Wagner', 'Saint Barthelemy', 'kind', 1038.0, 1048.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM manager ORDER BY name DESC, manager.manager_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Noah Rhodes',)
*/

-- Prediction Query
SELECT Name FROM manager ORDER BY Age DESC, manager.manager_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Daniel Wagner',)
*/