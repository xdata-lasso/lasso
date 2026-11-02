-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (2, NULL, NULL), (1, 'default1', 2), (-1, NULL, NULL), (3, 'iPhone', 2), (4, 'default2', 1), (5, 'default2', NULL), (6, 'default1', NULL), (7, 'iPhone', 1), (8, 'iPhone', 1), (9, 'S8', 1), (10, NULL, NULL), (11, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, -1, 2, NULL, 1, 2), (2, 0, 1, '2023-01-02', 1, NULL), (9, -1, NULL, '2023-01-01', NULL, NULL), (NULL, 0, 0, NULL, NULL, 1), (8, -1, -1, '2023-01-02', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME IN ('S8', 'iPhone') GROUP BY BUYER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 1 AND MAX(PRODUCT_NAME) = 'S8';

/*
Prediction Result:
(None,)
*/