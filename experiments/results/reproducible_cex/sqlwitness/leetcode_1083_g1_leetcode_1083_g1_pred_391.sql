-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, 2), (2, 'S8', 2), (0, 'S8', 1), (-1, 'S8', 2), (3, 'default2', 2), (4, NULL, 2), (5, 'default2', 2), (6, 'default2', 2), (7, 'iPhone', NULL), (8, 'iPhone', 2), (9, 'default2', NULL), (10, 'default1', NULL), (11, 'default1', NULL), (12, NULL, 2), (13, 'iPhone', 1), (14, 'default1', 1), (15, 'default2', 2), (16, NULL, 2), (17, 'S8', NULL), (18, NULL, 2), (19, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (17, 0, 2, NULL, NULL, 1), (5, NULL, 2, '2023-01-02', NULL, 2), (3, -1, 1, NULL, 1, NULL), (4, -1, 1, '2023-01-02', 1, 2), (9, NULL, 2, '2023-01-01', 1, NULL), (11, 1, -1, NULL, 2, NULL), (10, 1, NULL, '2023-01-01', NULL, 1), (8, 1, -1, NULL, NULL, NULL), (-1, NULL, 0, '2023-01-01', 1, NULL), (13, NULL, -1, '2023-01-01', 1, 2), (13, 0, NULL, NULL, 2, 2), (15, 2, 1, NULL, 2, NULL), (8, NULL, 1, '2023-01-01', 2, 1), (13, NULL, NULL, '2023-01-01', 1, 2), (13, 2, 1, '2023-01-01', 1, 1);
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
SELECT DISTINCT BUYER_ID FROM SALES CROSS JOIN PRODUCT WHERE BUYER_ID IN (SELECT BUYER_ID FROM SALES AS S CROSS JOIN PRODUCT AS P WHERE S.PRODUCT_ID = P.PRODUCT_ID AND P.PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES AS S CROSS JOIN PRODUCT AS P WHERE S.PRODUCT_ID = P.PRODUCT_ID AND P.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/