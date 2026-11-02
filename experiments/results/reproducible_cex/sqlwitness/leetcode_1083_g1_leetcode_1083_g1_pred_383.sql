-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', 1), (2, 'default2', 2), (1, 'G4', 2), (-1, NULL, NULL), (3, NULL, 2), (4, 'default2', NULL), (5, 'default2', 2), (6, 'G4', NULL), (7, 'default2', 2), (8, 'S8', 1), (9, 'S8', 1), (10, 'default1', 2), (11, 'G4', NULL), (12, 'iPhone', 2), (13, 'default2', 2), (14, 'G4', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 2, 0, '2023-01-01', 2, NULL), (2, 0, -1, '2023-01-02', NULL, 1), (5, 1, -1, '2023-01-02', NULL, 2), (NULL, 2, 2, NULL, 1, 1), (6, 2, -1, '2023-01-02', 2, 2), (10, NULL, 1, '2023-01-01', 2, NULL), (13, 2, -1, '2023-01-01', 1, 1), (13, -1, NULL, NULL, NULL, 1), (NULL, 0, 1, '2023-01-02', 1, 2), (-1, -1, -1, '2023-01-02', NULL, NULL), (14, 1, 0, NULL, 1, 1), (5, -1, 1, NULL, NULL, 2), (13, -1, 0, '2023-01-01', NULL, 2), (8, NULL, 0, NULL, 2, NULL), (0, 0, -1, '2023-01-02', NULL, NULL), (-1, 2, 0, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(0,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM (SELECT A.BUYER_ID, B.PRODUCT_NAME FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID) AS T1 WHERE PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT A.BUYER_ID FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.PRODUCT_NAME IN ('G4', 'iPhone'));

/*
Prediction Result:
*/