-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 2), (-1, NULL, 1), (0, 'default1', 1), (2, NULL, 1), (3, 'default1', NULL), (4, 'default1', 2), (5, 'S8', 1), (6, 'S8', NULL), (7, 'S8', NULL), (8, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 2, 0, NULL, NULL, NULL), (5, -1, NULL, '2023-01-01', 1, 2), (3, 2, 2, NULL, 2, NULL), (7, 2, 0, NULL, 1, 2), (5, NULL, NULL, '2023-01-01', 1, 2), (2, 1, 1, NULL, 2, NULL), (3, NULL, 2, '2023-01-02', NULL, 1), (1, 2, 2, '2023-01-01', 1, 1), (1, NULL, 0, NULL, 1, NULL), (8, 2, NULL, '2023-01-02', NULL, NULL), (8, 1, 2, NULL, 2, 1), (8, 2, 2, '2023-01-02', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8') AND NOT S.BUYER_ID IN (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone'));

/*
Prediction Result:
(0,)
(None,)
*/