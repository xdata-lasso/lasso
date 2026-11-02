-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 2), (0, 'default2', NULL), (2, 'default2', NULL), (-1, 'default2', 2), (3, 'default1', 1), (4, NULL, 2), (5, 'default2', 1), (6, 'default1', NULL), (7, 'S8', 1), (8, 'iPhone', NULL), (9, NULL, NULL), (10, NULL, 1), (11, 'S8', 1), (12, NULL, NULL), (13, 'S8', 2), (14, 'iPhone', NULL), (15, 'S8', 1), (16, 'iPhone', NULL), (17, 'iPhone', 1), (18, 'default2', 1), (19, 'default2', 2), (20, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, -1, NULL, NULL, 2), (2, NULL, 0, NULL, NULL, 2), (20, -1, 2, '2023-01-01', 2, NULL), (5, -1, 0, NULL, 1, 2), (6, 0, NULL, '2023-01-02', NULL, NULL), (18, NULL, 2, NULL, 2, 1), (15, 2, 1, '2023-01-02', 2, 1), (19, NULL, 0, NULL, 1, 1), (1, 2, NULL, '2023-01-01', 2, 2);
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
SELECT DISTINCT (BUYER_ID) FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE S.BUYER_ID IN (SELECT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8') AND NOT S.BUYER_ID IN (SELECT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/