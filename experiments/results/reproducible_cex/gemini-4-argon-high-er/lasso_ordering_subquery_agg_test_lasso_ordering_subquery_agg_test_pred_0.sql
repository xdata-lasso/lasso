-- Schema DDL
CREATE TABLE "Item" ("id" INTEGER PRIMARY KEY, "name" TEXT, "qty" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Item (id, name, qty) VALUES (1, 'B', 10);
INSERT INTO Item (id, name, qty) VALUES (2, 'A', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Item WHERE qty = (SELECT MAX(qty) FROM Item) ORDER BY name, Item.id NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT name FROM Item WHERE qty = (SELECT MAX(qty) FROM Item);

/*
Prediction Result:
('B',)
('A',)
*/