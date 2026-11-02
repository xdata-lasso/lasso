-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1020, 'Mark Ferguson', 'election', 1021.5, 'common', 'maintain');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1023, 'Randy Brown', 'term', 1024.5, 'almost', 'support');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1026, 'Christy Porter', 'usually', 1027.5, 'who', 'question');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1022, 1020, 'William Bowman', 'onto', 'discuss', 'reveal');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1025, 1023, 'William Bowman', 'certainly', 'our', 'under');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1028, 1026, 'Jessica Silva', 'high', 'nothing', 'everyone');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM captain ORDER BY name, captain.captain_id NULLS LAST;

/*
Gold Result:
('Jessica Silva',)
('William Bowman',)
('William Bowman',)
*/

-- Prediction Query
SELECT name FROM captain ORDER BY age DESC, captain.captain_id NULLS LAST;

/*
Prediction Result:
('William Bowman',)
('Jessica Silva',)
('William Bowman',)
*/