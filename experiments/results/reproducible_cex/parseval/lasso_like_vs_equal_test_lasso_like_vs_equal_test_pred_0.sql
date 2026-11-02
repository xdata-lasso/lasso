-- Schema DDL
CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("id", "name") VALUES (-2147483648, 'App');

INSERT INTO "products" ("id", "name") VALUES (2, 'App');

INSERT INTO "products" ("id", "name") VALUES (3, 'App');

INSERT INTO "products" ("id", "name") VALUES (-2147483645, 'A');

INSERT INTO "products" ("id", "name") VALUES (-2147483644, 'App');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM products WHERE name LIKE 'App%';

/*
Gold Result:
('App',)
('App',)
('App',)
('App',)
*/

-- Prediction Query
SELECT name FROM products WHERE name = 'App%';

/*
Prediction Result:
*/