-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "store1", "store2", "store3") VALUES (-2147483648, 1, 1, 1);

INSERT INTO "products" ("product_id", "store1", "store2", "store3") VALUES (1, -55602865, 1, -59984348);

INSERT INTO "products" ("product_id", "store1", "store2", "store3") VALUES (-2147483646, 1, 1, 1);

INSERT INTO "products" ("product_id", "store1", "store2", "store3") VALUES (-2147483645, 1, 1, 1);

INSERT INTO "products" ("product_id", "store1", "store2", "store3") VALUES (-2147483644, 1, 1, 1);

INSERT INTO "products" ("product_id", "store1", "store2", "store3") VALUES (-2147483643, NULL, 1, 1);

INSERT INTO "products" ("product_id", "store1", "store2", "store3") VALUES (-2147483642, 1, NULL, 1);

INSERT INTO "products" ("product_id", "store1", "store2", "store3") VALUES (-2147483641, 1, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(-2147483648, 'store1', 1)
(-2147483648, 'store2', 1)
(-2147483648, 'store3', 1)
(-2147483646, 'store1', 1)
(-2147483646, 'store2', 1)
(-2147483646, 'store3', 1)
(-2147483645, 'store1', 1)
(-2147483645, 'store2', 1)
(-2147483645, 'store3', 1)
(-2147483644, 'store1', 1)
(-2147483644, 'store2', 1)
(-2147483644, 'store3', 1)
(-2147483643, 'store2', 1)
(-2147483643, 'store3', 1)
(-2147483642, 'store1', 1)
(-2147483642, 'store3', 1)
(-2147483641, 'store1', 1)
(-2147483641, 'store2', 1)
(1, 'store1', -55602865)
(1, 'store2', 1)
(1, 'store3', -59984348)
*/

-- Prediction Query
SELECT PRODUCT_ID, 'store1' AS STORE, STORE1 AS PRICE FROM PRODUCTS WHERE STORE1 > 0 UNION SELECT PRODUCT_ID, 'store2' AS STORE, STORE2 AS PRICE FROM PRODUCTS WHERE STORE2 > 0 UNION SELECT PRODUCT_ID, 'store3' AS STORE, STORE3 AS PRICE FROM PRODUCTS WHERE STORE3 > 0;

/*
Prediction Result:
(-2147483648, 'store1', 1)
(-2147483648, 'store2', 1)
(-2147483648, 'store3', 1)
(-2147483646, 'store1', 1)
(-2147483646, 'store2', 1)
(-2147483646, 'store3', 1)
(-2147483645, 'store1', 1)
(-2147483645, 'store2', 1)
(-2147483645, 'store3', 1)
(-2147483644, 'store1', 1)
(-2147483644, 'store2', 1)
(-2147483644, 'store3', 1)
(-2147483643, 'store2', 1)
(-2147483643, 'store3', 1)
(-2147483642, 'store1', 1)
(-2147483642, 'store3', 1)
(-2147483641, 'store1', 1)
(-2147483641, 'store2', 1)
(1, 'store2', 1)
*/