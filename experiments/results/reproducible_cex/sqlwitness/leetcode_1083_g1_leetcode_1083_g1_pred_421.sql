-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', NULL), (0, NULL, NULL), (-1, 'S8', NULL), (1, 'iPhone', NULL), (3, 'S8', 2), (4, 'S8', NULL), (5, 'default1', 1), (6, 'default2', NULL), (7, NULL, 2), (8, 'default1', 2), (9, NULL, 2), (10, 'S8', NULL), (11, 'G4', 2), (12, 'default2', NULL), (13, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, 2, -1, '2023-01-02', 1, 2), (7, 0, -1, '2023-01-02', 2, 1), (1, 1, 0, '2023-01-02', 2, 2), (8, 0, NULL, '2023-01-02', 2, 2), (-1, NULL, NULL, '2023-01-01', 1, NULL), (-1, 2, 1, '2023-01-01', 2, NULL), (-1, -1, -1, '2023-01-02', NULL, 1), (8, -1, NULL, '2023-01-02', 1, NULL), (6, 1, 0, '2023-01-01', 1, NULL), (8, 2, 0, '2023-01-01', NULL, 1), (11, NULL, 2, '2023-01-01', 2, NULL), (2, 2, 1, '2023-01-01', NULL, 1), (10, 2, -1, '2023-01-01', 2, NULL), (4, 0, 1, '2023-01-01', 2, NULL), (3, 2, -1, '2023-01-02', 2, 2), (2, 2, 2, '2023-01-02', 2, 2), (12, NULL, 1, '2023-01-02', NULL, 1), (12, -1, -1, NULL, 1, 2), (-1, 2, 0, '2023-01-01', NULL, NULL), (6, 1, 2, NULL, 1, NULL), (5, 0, -1, '2023-01-02', NULL, 2), (8, 0, 0, '2023-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(1,)
(2,)
*/

-- Prediction Query
SELECT B.BUYER_ID FROM (SELECT A.BUYER_ID, SUM(CASE WHEN A.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8, SUM(CASE WHEN A.PRODUCT_NAME = 'G4' THEN 1 ELSE 0 END) AS G4, SUM(CASE WHEN A.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE FROM (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) AS A GROUP BY A.BUYER_ID) AS B WHERE B.S8 >= 1 AND B.IPHONE = 0;

/*
Prediction Result:
(None,)
(-1,)
(1,)
(2,)
*/