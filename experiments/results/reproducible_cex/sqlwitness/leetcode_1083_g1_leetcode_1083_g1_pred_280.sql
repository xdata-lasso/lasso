-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 2), (0, 'S8', 1), (-1, 'default2', 1), (2, 'default1', NULL), (3, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 2, NULL, '2023-01-02', 2, 2), (-1, 2, -1, '2023-01-01', 2, 1), (0, -1, 2, '2023-01-01', 1, NULL), (NULL, -1, NULL, NULL, 2, 2), (0, 0, 1, '2023-01-02', 1, 2), (3, 0, NULL, NULL, NULL, NULL), (NULL, -1, 1, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
WITH T AS (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8' OR P.PRODUCT_NAME = 'iPhone') SELECT DISTINCT (BUYER_ID) FROM T WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM T WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(None,)
(2,)
(1,)
*/