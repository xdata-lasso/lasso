-- Schema DDL
CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE products (id INTEGER PRIMARY KEY, cat_id INTEGER, title TEXT, FOREIGN KEY (cat_id) REFERENCES categories (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: categories --
INSERT INTO "categories" ("id", "name") VALUES (1, 'Electronics');

INSERT INTO "categories" ("id", "name") VALUES (-2147483647, 'Electronics');

INSERT INTO "categories" ("id", "name") VALUES (2, 'Electronics');

INSERT INTO "categories" ("id", "name") VALUES (4, '5k5swwqcgs');

-- Inserting into table: products --
INSERT INTO "products" ("id", "cat_id", "title") VALUES (-2147483648, 1, 'p_s_cf385f');

INSERT INTO "products" ("id", "cat_id", "title") VALUES (2, 1, 'p_s_cf385f');

INSERT INTO "products" ("id", "cat_id", "title") VALUES (3, 1, 'p_s_cf385f');

INSERT INTO "products" ("id", "cat_id", "title") VALUES (-2147483645, 4, 'p_s_cf385f');

INSERT INTO "products" ("id", "cat_id", "title") VALUES (-2147483644, 4, 'p_s_cf385f');

INSERT INTO "products" ("id", "cat_id", "title") VALUES (-2147483643, 4, 'p_s_cf385f');

INSERT INTO "products" ("id", "cat_id", "title") VALUES (-2147483642, 1, 'p_s_cf385f');

INSERT INTO "products" ("id", "cat_id", "title") VALUES (-2147483641, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.title FROM products AS p JOIN categories AS c ON p.cat_id = c.id WHERE c.name = 'Electronics';

/*
Gold Result:
('p_s_cf385f',)
('p_s_cf385f',)
(None,)
('p_s_cf385f',)
('p_s_cf385f',)
*/

-- Prediction Query
SELECT p.title FROM products AS p WHERE p.cat_id = 7;

/*
Prediction Result:
*/