-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default2', 2), (-1, 'default2', 1), (1, 'iPhone', NULL), (0, 'iPhone', NULL), (3, NULL, 1), (4, 'default1', 1), (5, 'iPhone', 2), (6, 'default1', 1), (7, NULL, NULL), (8, 'default1', NULL), (9, 'default1', 1), (10, 'S8', NULL), (11, 'default1', 1), (12, 'iPhone', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, 1, NULL, '2023-01-02', 1, NULL), (9, 1, 2, '2023-01-02', NULL, NULL), (NULL, -1, 0, '2023-01-01', 1, NULL), (2, 1, 0, '2023-01-02', NULL, 2), (0, 0, 1, '2023-01-01', NULL, 2), (11, NULL, 2, NULL, 2, NULL), (2, 1, 2, '2023-01-01', 1, 1), (10, -1, 2, '2023-01-01', 1, 2), (1, -1, NULL, '2023-01-01', 2, 1), (NULL, 2, 0, '2023-01-01', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8' AND NOT S.BUYER_ID IN (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone')) GROUP BY 1;

/*
Prediction Result:
(2,)
*/