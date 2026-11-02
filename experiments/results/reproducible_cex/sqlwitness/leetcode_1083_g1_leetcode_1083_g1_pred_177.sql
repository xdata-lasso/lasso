-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default1', NULL), (-1, 'iPhone', NULL), (1, 'default1', NULL), (0, 'S8', 1), (3, 'default1', 2), (4, 'default2', 1), (5, 'iPhone', NULL), (6, 'default1', 2), (7, 'S8', 1), (8, NULL, 1), (9, 'default2', 2), (10, 'S8', NULL), (11, 'S8', 1), (12, NULL, 2), (13, 'iPhone', 2), (14, 'default2', 1), (15, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (13, 2, NULL, NULL, 1, 2), (8, -1, -1, NULL, 2, 2), (7, 2, NULL, '2023-01-01', 1, 1), (11, 2, 1, NULL, NULL, 2), (NULL, 1, -1, '2023-01-01', 2, 2), (12, 0, 1, NULL, 1, 1), (7, 1, -1, NULL, 2, 1), (13, 0, 0, '2023-01-02', 1, 2), (4, 1, 2, NULL, 1, NULL), (13, 1, 1, '2023-01-02', 2, 1), (8, NULL, 2, '2023-01-01', 2, NULL), (NULL, 2, -1, '2023-01-01', NULL, 1), (5, 0, NULL, NULL, 1, NULL), (7, NULL, 1, '2023-01-02', 1, 1), (7, 0, 0, '2023-01-01', 1, NULL), (4, NULL, 1, NULL, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT DISTINCT S.BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE BUYER_ID IN (SELECT S.BUYER_ID FROM SALES AS S CROSS JOIN PRODUCT AS P WHERE P.PRODUCT_ID = S.PRODUCT_ID AND PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT S.BUYER_ID FROM SALES AS S CROSS JOIN PRODUCT AS P WHERE P.PRODUCT_ID = S.PRODUCT_ID AND PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/