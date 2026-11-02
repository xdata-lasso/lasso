-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, 2), (0, 'default2', 2), (-1, NULL, 2), (1, NULL, 1), (3, 'default2', NULL), (4, 'iPhone', 1), (5, 'iPhone', 1), (6, 'iPhone', NULL), (7, 'iPhone', 2), (8, 'S8', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, NULL, 2, '2023-01-01', NULL, 1), (-1, -1, -1, '2023-01-02', 2, NULL), (3, 0, 1, NULL, NULL, NULL), (8, 1, 0, '2023-01-01', 1, NULL), (5, 2, NULL, NULL, NULL, 2), (1, NULL, 2, '2023-01-02', 1, NULL), (2, 2, 1, NULL, 1, 2), (8, 2, NULL, NULL, NULL, NULL), (0, -1, 1, '2023-01-02', 2, 2), (3, 2, 1, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT A.BUYER_ID FROM (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8') AS A LEFT JOIN (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone') AS B ON A.BUYER_ID = B.BUYER_ID WHERE B.PRODUCT_NAME IS NULL;

/*
Prediction Result:
(0,)
(None,)
*/