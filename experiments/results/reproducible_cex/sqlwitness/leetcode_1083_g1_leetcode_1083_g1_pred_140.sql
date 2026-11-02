-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', NULL), (2, 'default1', 1), (-1, 'iPhone', 1), (0, 'S8', 2), (3, 'iPhone', 1), (4, 'iPhone', NULL), (5, 'S8', 1), (6, 'iPhone', 2), (7, 'iPhone', 2), (8, 'default2', 2), (9, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 0, 0, '2023-01-02', 1, 2), (2, 0, 0, NULL, 1, NULL), (7, 2, NULL, '2023-01-01', NULL, NULL), (0, NULL, NULL, '2023-01-01', NULL, NULL), (NULL, NULL, NULL, '2023-01-02', 2, 2), (-1, -1, 1, '2023-01-02', 2, NULL), (9, 1, 2, '2023-01-01', 2, 2), (0, 1, -1, NULL, 2, NULL), (7, 1, 0, '2023-01-02', NULL, 1), (NULL, 0, 2, '2023-01-02', 2, 1), (6, NULL, 0, '2023-01-02', 1, 2), (3, NULL, 0, NULL, 1, NULL), (3, 0, 1, '2023-01-01', NULL, NULL), (2, 1, 2, '2023-01-01', NULL, 2), (-1, NULL, NULL, '2023-01-01', NULL, NULL), (8, 1, 0, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT DISTINCT A.BUYER_ID FROM SALES AS A INNER JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE A.BUYER_ID IN (SELECT C.BUYER_ID FROM SALES AS C INNER JOIN PRODUCT AS D ON C.PRODUCT_ID = D.PRODUCT_ID WHERE D.PRODUCT_NAME = 'S8') AND NOT A.BUYER_ID IN (SELECT C.BUYER_ID FROM SALES AS C INNER JOIN PRODUCT AS D ON C.PRODUCT_ID = D.PRODUCT_ID WHERE D.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/