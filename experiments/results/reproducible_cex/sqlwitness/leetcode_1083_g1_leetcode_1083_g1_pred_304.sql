-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', 1), (1, 'default1', 2), (2, 'default1', 1), (-1, 'S8', 2), (3, 'default2', NULL), (4, 'default2', NULL), (5, 'S8', NULL), (6, 'default1', 2), (7, 'S8', 1), (8, 'S8', NULL), (9, 'S8', NULL), (10, 'default1', NULL), (11, 'iPhone', 1), (12, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 1, -1, NULL, 1, 2), (NULL, 0, 2, NULL, NULL, 1), (7, 1, 0, '2023-01-02', 2, NULL), (7, 2, 0, NULL, NULL, 1), (10, 2, 1, NULL, NULL, 1), (8, -1, 2, '2023-01-01', NULL, NULL), (1, 1, 1, '2023-01-01', 2, 1), (0, NULL, NULL, '2023-01-01', 2, 1), (-1, -1, NULL, '2023-01-01', 1, NULL), (0, 2, 2, '2023-01-02', 1, 1), (6, NULL, -1, NULL, NULL, NULL), (5, 1, 0, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone'));

/*
Prediction Result:
(0,)
(2,)
(None,)
*/