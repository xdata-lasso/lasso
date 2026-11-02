-- Schema DDL
CREATE TABLE product (product_id INTEGER PRIMARY KEY, product_name TEXT);

CREATE TABLE store (Store_ID INTEGER PRIMARY KEY, Store_Name TEXT);

CREATE TABLE store_product (Store_ID INTEGER, Product_ID INTEGER, PRIMARY KEY (Store_ID, Product_ID), FOREIGN KEY (Product_ID) REFERENCES product (Product_ID), FOREIGN KEY (Store_ID) REFERENCES store (Store_ID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO store (store_id, store_name) VALUES (0, 'Miramichi'), (1, 'Miramichi'), (2, 'default2'), (3, 'default2'), (4, 'default2'), (5, 'Miramichi'), (6, NULL);
INSERT INTO product (product_id, product_name) VALUES (0, 'default1'), (1, 'default2'), (2, 'Miramichi'), (3, NULL), (4, 'default1'), (5, 'default2'), (6, NULL);
INSERT INTO store_product (store_id, product_id) VALUES (2, 1), (0, 0), (5, 4), (2, 3), (2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM product JOIN store_product ON product.product_id = store_product.Product_ID JOIN store ON store_product.Store_ID = store.Store_ID WHERE Store_Name <> 'Miramichi';

/*
Gold Result:
('default2',)
(None,)
('Miramichi',)
*/

-- Prediction Query
SELECT product_name FROM product JOIN store_product ON product.product_id = store_product.Product_ID JOIN store ON store_product.Store_ID = store.Store_ID WHERE Store_Name = 'Miramichi';

/*
Prediction Result:
('default1',)
('default1',)
*/