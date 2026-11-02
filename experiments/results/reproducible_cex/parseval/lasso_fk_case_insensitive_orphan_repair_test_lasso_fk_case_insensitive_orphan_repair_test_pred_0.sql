-- Schema DDL
CREATE TABLE product (product_id INTEGER PRIMARY KEY, product_name TEXT);

CREATE TABLE store (Store_ID INTEGER PRIMARY KEY, Store_Name TEXT);

CREATE TABLE store_product (Store_ID INTEGER, Product_ID INTEGER, PRIMARY KEY (Store_ID, Product_ID), FOREIGN KEY (Product_ID) REFERENCES product (Product_ID), FOREIGN KEY (Store_ID) REFERENCES store (Store_ID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name") VALUES (1, 'pro_b57164');

INSERT INTO "product" ("product_id", "product_name") VALUES (-2147483647, 'pro_b57164');

INSERT INTO "product" ("product_id", "product_name") VALUES (3, 'pro_b57164');

INSERT INTO "product" ("product_id", "product_name") VALUES (2, '5k5swwqcgs');

INSERT INTO "product" ("product_id", "product_name") VALUES (4, '5k5swwqcgs');

INSERT INTO "product" ("product_id", "product_name") VALUES (5, '9n8');

INSERT INTO "product" ("product_id", "product_name") VALUES (6, NULL);

-- Inserting into table: store --
INSERT INTO "store" ("store_id", "store_name") VALUES (1, 'sto_0ff350');

INSERT INTO "store" ("store_id", "store_name") VALUES (-2147483647, 'sto_bab105');

INSERT INTO "store" ("store_id", "store_name") VALUES (3, 'sto_0ff350');

INSERT INTO "store" ("store_id", "store_name") VALUES (2, '9n8');

INSERT INTO "store" ("store_id", "store_name") VALUES (4, 'Miramichi');

INSERT INTO "store" ("store_id", "store_name") VALUES (5, NULL);

INSERT INTO "store" ("store_id", "store_name") VALUES (6, 'sto_58f965');

-- Inserting into table: store_product --
INSERT INTO "store_product" ("store_id", "product_id") VALUES (1, 1);

INSERT INTO "store_product" ("store_id", "product_id") VALUES (1, 2);

INSERT INTO "store_product" ("store_id", "product_id") VALUES (2, 1);

INSERT INTO "store_product" ("store_id", "product_id") VALUES (4, 4);

INSERT INTO "store_product" ("store_id", "product_id") VALUES (5, 5);

INSERT INTO "store_product" ("store_id", "product_id") VALUES (6, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM product JOIN store_product ON product.product_id = store_product.Product_ID JOIN store ON store_product.Store_ID = store.Store_ID WHERE Store_Name <> 'Miramichi';

/*
Gold Result:
('pro_b57164',)
('5k5swwqcgs',)
('pro_b57164',)
(None,)
*/

-- Prediction Query
SELECT product_name FROM product JOIN store_product ON product.product_id = store_product.Product_ID JOIN store ON store_product.Store_ID = store.Store_ID WHERE Store_Name = 'Miramichi';

/*
Prediction Result:
('5k5swwqcgs',)
*/