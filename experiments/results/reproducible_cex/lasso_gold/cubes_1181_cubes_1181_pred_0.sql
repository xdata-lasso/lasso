-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1001, 'Allison Hill', 'agreement', 1005.5, 'rate', 'discussion');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1002, 'Noah Rhodes', 'option', 1014.5, 'science', 'list');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1003, 'Angie Henderson', 'decide', 1023.5, 'offer', 'perform');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1004, 'Daniel Wagner', 'sense', 1032.5, 'kind', 'fall');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1009, 1001, 'Abigail Shaffer', 'surface', 'not', 'bar');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1010, 1001, 'Gina Moore', 'animal', 'capital', 'old');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1011, 1001, 'Gabrielle Davis', 'show', 'win', 'finally');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1012, 1001, 'Ryan Munoz', 'machine', 'human', 'themselves');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM captain ORDER BY ship_id DESC, captain.captain_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Abigail Shaffer',)
*/

-- Prediction Query
SELECT name FROM captain ORDER BY age, captain.captain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Gina Moore',)
*/