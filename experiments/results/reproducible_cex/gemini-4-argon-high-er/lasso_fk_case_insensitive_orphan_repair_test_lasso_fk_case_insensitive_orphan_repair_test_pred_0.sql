-- Schema DDL
CREATE TABLE product (product_id INTEGER PRIMARY KEY, product_name TEXT);

CREATE TABLE store (Store_ID INTEGER PRIMARY KEY, Store_Name TEXT);

CREATE TABLE store_product (Store_ID INTEGER, Product_ID INTEGER, PRIMARY KEY (Store_ID, Product_ID), FOREIGN KEY (Product_ID) REFERENCES product (Product_ID), FOREIGN KEY (Store_ID) REFERENCES store (Store_ID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name) VALUES (1, 'Apple');
INSERT INTO store (Store_ID, Store_Name) VALUES (1, 'Miramichi');
INSERT INTO store_product (Store_ID, Product_ID) VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM product JOIN store_product ON product.product_id = store_product.Product_ID JOIN store ON store_product.Store_ID = store.Store_ID WHERE Store_Name <> 'Miramichi';

/*
Gold Result:
*/

-- Prediction Query
SELECT product_name FROM product JOIN store_product ON product.product_id = store_product.Product_ID JOIN store ON store_product.Store_ID = store.Store_ID WHERE Store_Name = 'Miramichi';

/*
Prediction Result:
('Apple',)
*/