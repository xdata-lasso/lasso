-- Schema DDL
CREATE TABLE "Item" ("id" INTEGER PRIMARY KEY, "name" TEXT, "qty" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO item (id, name, qty) VALUES (1, 'default1', 1), (0, 'default1', NULL), (2, NULL, 1), (3, 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Item WHERE qty = (SELECT MAX(qty) FROM Item) ORDER BY name, Item.id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT name FROM Item WHERE qty = (SELECT MAX(qty) FROM Item);

/*
Prediction Result:
('default1',)
(None,)
*/