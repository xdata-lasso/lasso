-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1095, 'Teresa Taylor', 'Democrat', 1098.5, 'tonight', 'middle');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1096, 'Brian Tran', 'right', 1107.5, 'everything', 'enter');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1097, 'Larry Robbins', 'protect', 1116.5, 'mouth', 'western');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1104, 'Stephanie Gardner', 'style', 1107.5, 'way', 'rest');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1105, 'Lauren Hernandez', 'traditional', 1116.5, 'help', 'enjoy');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1106, 'Eric Nolan', 'among', 1125.5, 'develop', 'reflect');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1101, 1095, 'Amber Walters', 'letter', 'late', 'brother');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1102, 1095, 'Amanda Cook', 'ok', 'option', 'bag');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1103, 1095, 'William Martin', 'season', 'act', 'you');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1110, 1104, 'Richard Henson', 'talk', 'itself', 'since');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1111, 1104, 'Marc Moore', 'cost', 'ago', 'window');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1112, 1104, 'Sharon Cherry', 'upon', 'country', 'go');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.ship_id AS ship_id, LHS.name AS name, LHS.type AS TYPE, LHS.built_year AS built_year, LHS.class AS CLASS, LHS.flag AS flag, RHS.n AS n FROM ship AS LHS INNER JOIN (SELECT ship_id, COUNT(*) AS n FROM captain GROUP BY ship_id) AS RHS ON (LHS.ship_id = RHS.ship_id)) WHERE (n > 1) ORDER BY name;

/*
Gold Result:
('Stephanie Gardner',)
('Teresa Taylor',)
*/

-- Prediction Query
SELECT t1.name FROM ship AS t1 JOIN captain AS t2 ON t1.ship_id = t2.ship_id GROUP BY t2.ship_id HAVING COUNT(*) > 1;

/*
Prediction Result:
('Teresa Taylor',)
('Stephanie Gardner',)
*/