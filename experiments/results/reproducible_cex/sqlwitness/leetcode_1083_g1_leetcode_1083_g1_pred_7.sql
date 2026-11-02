-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 2), (1, 'default1', 2), (2, 'S8', 1), (-1, NULL, 2), (3, 'iPhone', NULL), (4, 'S8', 1), (5, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 1, '2023-01-02', 2, 2), (2, NULL, -1, '2023-01-02', NULL, NULL), (3, -1, 2, NULL, 1, 1), (4, NULL, 2, '2023-01-02', NULL, 2), (4, 0, 2, NULL, NULL, NULL), (3, 1, NULL, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT DISTINCT S1.BUYER_ID FROM SALES AS S1 CROSS JOIN PRODUCT AS P WHERE S1.PRODUCT_ID = P.PRODUCT_ID AND P.PRODUCT_NAME = 'S8' AND NOT S1.BUYER_ID IN (SELECT S1.BUYER_ID AS IPHONE FROM SALES AS S1 CROSS JOIN PRODUCT AS P WHERE S1.PRODUCT_ID = P.PRODUCT_ID AND P.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/