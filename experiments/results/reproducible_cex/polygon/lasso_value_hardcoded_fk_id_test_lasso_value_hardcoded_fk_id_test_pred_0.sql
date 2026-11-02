-- Schema DDL
CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE products (id INTEGER PRIMARY KEY, cat_id INTEGER, title TEXT, FOREIGN KEY (cat_id) REFERENCES categories (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "categories" ("id", "name") VALUES (10, 'Electronics17');
INSERT INTO "categories" ("id", "name") VALUES (17, 'Electronics');
INSERT INTO "products" ("id", "cat_id", "title") VALUES (15, 17, NULL);
INSERT INTO "products" ("id", "cat_id", "title") VALUES (16, 17, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.title FROM products AS p JOIN categories AS c ON p.cat_id = c.id WHERE c.name = 'Electronics';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT p.title FROM products AS p WHERE p.cat_id = 7;

/*
Prediction Result:
*/