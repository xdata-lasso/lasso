-- Schema DDL
CREATE TABLE "Item" ("id" INTEGER PRIMARY KEY, "name" TEXT, "qty" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "item" ("id", "name", "qty") VALUES (1032, 'Holly Wood', 1033);
INSERT INTO "item" ("id", "name", "qty") VALUES (1034, 'Dylan Miller', 1033);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Item WHERE qty = (SELECT MAX(qty) FROM Item) ORDER BY name, Item.id NULLS LAST;

/*
Gold Result:
('Dylan Miller',)
('Holly Wood',)
*/

-- Prediction Query
SELECT name FROM Item WHERE qty = (SELECT MAX(qty) FROM Item);

/*
Prediction Result:
('Holly Wood',)
('Dylan Miller',)
*/