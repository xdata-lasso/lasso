-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', NULL), (2, 'S8', 1), (-1, 'default2', 2), (1, 'iPhone', 1), (3, 'S8', NULL), (4, 'default1', 1), (5, 'default1', NULL), (6, 'S8', NULL), (7, 'iPhone', 2), (8, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, NULL, '2023-01-01', NULL, NULL), (6, 0, 2, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM PRODUCT INNER JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT DISTINCT BUYER_ID FROM PRODUCT INNER JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(None,)
(2,)
*/