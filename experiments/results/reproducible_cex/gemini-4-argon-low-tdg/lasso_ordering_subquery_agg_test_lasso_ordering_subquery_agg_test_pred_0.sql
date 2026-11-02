-- Schema DDL
CREATE TABLE "Item" ("id" INTEGER PRIMARY KEY, "name" TEXT, "qty" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Item (id, name, qty) VALUES (1, 'Zebra', 100);
INSERT INTO Item (id, name, qty) VALUES (2, 'Apple', 100);
INSERT INTO Item (id, name, qty) VALUES (3, 'Mango', 50);
INSERT INTO Item (id, name, qty) VALUES (4, 'Banana', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Item WHERE qty = (SELECT MAX(qty) FROM Item) ORDER BY name, Item.id NULLS LAST;

/*
Gold Result:
('Apple',)
('Zebra',)
*/

-- Prediction Query
SELECT name FROM Item WHERE qty = (SELECT MAX(qty) FROM Item);

/*
Prediction Result:
('Zebra',)
('Apple',)
*/