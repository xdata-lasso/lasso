-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default2', 1), (-1, 'S8', NULL), (1, 'default2', NULL), (0, 'S8', NULL), (3, 'S8', 1), (4, 'iPhone', 2), (5, 'default1', 2), (6, 'default1', 2), (7, 'S8', 1), (8, 'default2', 2), (9, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, NULL, 0, '2023-01-02', 2, 1), (1, NULL, NULL, NULL, NULL, NULL), (8, 2, NULL, '2023-01-01', NULL, NULL), (3, 0, 1, NULL, 2, NULL), (4, 2, 2, '2023-01-01', NULL, 1), (6, 2, NULL, '2023-01-02', NULL, 2), (0, NULL, NULL, NULL, NULL, 1), (9, -1, NULL, NULL, NULL, NULL), (1, NULL, -1, '2023-01-01', NULL, 2), (5, -1, 1, NULL, NULL, 2), (-1, 1, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME IN ('S8', 'iPhone')) GROUP BY BUYER_ID HAVING SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(None,)
(1,)
*/