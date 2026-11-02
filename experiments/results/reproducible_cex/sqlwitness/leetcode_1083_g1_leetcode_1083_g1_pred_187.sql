-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 2), (0, 'S8', 2), (-1, 'default1', 1), (2, 'iPhone', 1), (3, 'S8', 2), (4, 'default2', 1), (5, 'S8', 2), (6, NULL, 1), (7, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, NULL, 1, '2023-01-01', 1, 2), (6, NULL, -1, '2023-01-02', 2, 2), (5, 1, NULL, '2023-01-02', 1, NULL), (6, 2, 0, '2023-01-01', NULL, 2), (5, 2, 1, NULL, 1, 1), (4, 2, 0, '2023-01-01', 1, 1), (-1, 1, 0, '2023-01-01', NULL, NULL), (5, 2, 2, '2023-01-02', 1, 2), (5, 2, 0, '2023-01-02', NULL, NULL), (7, 1, 2, '2023-01-01', 1, 1), (2, 1, 0, '2023-01-01', NULL, NULL), (6, -1, 2, '2023-01-02', 2, NULL), (7, NULL, 2, '2023-01-02', 2, NULL), (3, NULL, 2, '2023-01-01', 2, 1), (5, 1, 1, '2023-01-01', 1, 1), (0, -1, 1, '2023-01-02', 2, NULL), (2, -1, NULL, '2023-01-02', 2, NULL);
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
SELECT S.BUYER_ID FROM (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8')) AS S LEFT OUTER JOIN (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone')) AS I ON S.BUYER_ID = I.BUYER_ID WHERE I.BUYER_ID IS NULL;

/*
Prediction Result:
(None,)
(1,)
(2,)
*/