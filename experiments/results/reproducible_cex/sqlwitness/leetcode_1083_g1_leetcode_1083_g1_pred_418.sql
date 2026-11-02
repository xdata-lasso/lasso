-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '%S8%', NULL), (-1, NULL, 2), (0, 'default2', 1), (2, 'S8', 2), (3, 'default1', 2), (4, '%IPHONE%', 2), (5, NULL, 1), (6, '%S8%', 2), (7, '%S8%', 1), (8, 'S8', NULL), (9, 'default2', 1), (10, '%S8%', 2), (11, 'default1', 1), (12, '%IPHONE%', NULL), (13, 'default1', NULL), (14, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, 1, -1, '2023-01-02', NULL, NULL), (0, 1, 1, '2023-01-02', NULL, NULL), (11, 2, 0, NULL, NULL, 2), (13, -1, -1, '2023-01-01', 2, 1), (8, NULL, 1, '2023-01-02', 2, 2), (13, 1, NULL, NULL, NULL, NULL), (2, 2, 0, '2023-01-01', NULL, 1), (4, 1, NULL, '2023-01-02', 2, NULL), (12, 0, NULL, '2023-01-02', 1, NULL), (11, -1, NULL, '2023-01-02', 2, 2), (10, -1, -1, '2023-01-02', NULL, NULL), (0, -1, 0, '2023-01-02', NULL, 2), (NULL, 0, -1, NULL, 2, NULL), (-1, NULL, 0, '2023-01-02', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT A.BUYER_ID FROM (SELECT A.BUYER_ID, GROUP_CONCAT(A.PRODUCT_NAME) AS GP FROM (SELECT S.BUYER_ID, S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID ORDER BY 1, S.product_id NULLS LAST, S.seller_id NULLS LAST, S.buyer_id NULLS LAST, S.sale_date NULLS LAST, S.quantity NULLS LAST, S.price NULLS LAST, P.product_id NULLS LAST) AS A GROUP BY 1 ORDER BY 1, A.BUYER_ID NULLS LAST, GP NULLS LAST) AS A WHERE A.GP LIKE '%S8%' AND A.GP NOT LIKE '%IPHONE%';

/*
Prediction Result:
(-1,)
(0,)
(1,)
*/