-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default1', NULL), (-1, 'default2', 1), (0, 'default1', NULL), (1, 'default1', 1), (3, 'default2', 1), (4, NULL, 1), (5, '%S8', 1), (6, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, NULL, -1, '2023-01-02', 2, 1), (2, -1, -1, '2023-01-02', NULL, 1), (0, 1, 0, NULL, NULL, 2), (5, 1, NULL, NULL, 2, 2), (4, 0, 0, '2023-01-01', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES JOIN PRODUCT USING (PRODUCT_ID) WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES JOIN PRODUCT USING (PRODUCT_ID) WHERE PRODUCT_NAME LIKE '%IPHONE%') AND PRODUCT_NAME LIKE '%S8';

/*
Prediction Result:
(None,)
*/