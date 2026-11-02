-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1013, 'Joe Martinez', 'spring', 1017.5, 'early', 'trial');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1014, 'Angela Carter', 'figure', 1017.5, 'early', 'blood');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1015, 'Stacey Ward', 'base', 1017.5, 'early', 'husband');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1016, 'Benjamin Stanley', 'top', 1017.5, 'early', 'fall');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1018, 'Roy Martin', 'expect', 1022.5, 'onto', 'discuss');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1019, 'Michael Miles', 'wish', 1022.5, 'onto', 'reveal');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1020, 'Andrea Reid', 'push', 1022.5, 'onto', 'garden');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1021, 'Danielle Ford', 'rise', 1022.5, 'onto', 'threat');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT built_year FROM (SELECT * FROM (SELECT * FROM (SELECT built_year, CLASS, MAX(n) AS n FROM (SELECT ship_id, name, TYPE, built_year, CLASS, flag, COUNT(*) OVER () AS n FROM ship) GROUP BY built_year, CLASS) ORDER BY CLASS DESC) LIMIT 1);

/*
Gold Result:
(1022.5,)
*/

-- Prediction Query
SELECT built_year FROM ship GROUP BY built_year ORDER BY COUNT(*) DESC, built_year NULLS LAST LIMIT 1;

/*
Prediction Result:
(1017.5,)
*/