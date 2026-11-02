-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default2', 2), (0, 'default2', NULL), (2, NULL, NULL), (1, NULL, NULL), (3, NULL, 2), (4, 'S8', 2), (5, 'S8', NULL), (6, 'iPhone', NULL), (7, 'iPhone', 1), (8, 'default1', 1), (9, 'S8', NULL), (10, 'iPhone', 1), (11, 'iPhone', 1), (12, NULL, 2), (13, 'default2', NULL), (14, NULL, 2), (15, 'default2', 1), (16, NULL, 2), (17, 'iPhone', 1), (18, 'iPhone', 1), (19, 'default1', NULL), (20, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, NULL, 1, '2023-01-01', 2, NULL), (12, 0, -1, NULL, 2, 2), (NULL, 0, 0, '2023-01-01', 2, NULL), (12, 2, NULL, '2023-01-02', 2, 2), (17, 0, NULL, '2023-01-02', NULL, 1), (8, 2, 2, '2023-01-01', 2, NULL), (8, 0, NULL, '2023-01-02', 1, NULL), (11, 1, NULL, '2023-01-01', 2, 1), (18, 2, 0, NULL, 1, 1), (9, 2, -1, NULL, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(1,)
*/

-- Prediction Query
SELECT DISTINCT S2.BUYER_ID FROM SALES AS S2 JOIN (SELECT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8') AS X ON X.BUYER_ID = S2.BUYER_ID WHERE NOT X.BUYER_ID IN (SELECT A.BUYER_ID FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/