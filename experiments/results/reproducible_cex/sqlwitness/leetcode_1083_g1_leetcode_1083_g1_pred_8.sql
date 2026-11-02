-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', NULL), (-1, 'default1', 1), (1, 'default2', 1), (2, 'S8', 2), (3, 'iPhone', 1), (4, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, 0, 0, NULL, 1, NULL), (-1, 1, 0, NULL, 1, 2), (4, NULL, NULL, '2023-01-01', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT SALES.BUYER_ID FROM PRODUCT CROSS JOIN SALES WHERE PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID AND PRODUCT.PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT CROSS JOIN SALES WHERE PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID AND PRODUCT.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(None,)
*/