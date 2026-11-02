-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, 2), (-1, 'default2', 2), (0, 'default1', NULL), (1, 'S8', 2), (3, 'default2', NULL), (4, 'default2', NULL), (5, 'default1', NULL), (6, 'default2', NULL), (7, NULL, NULL), (8, 'S8', 2), (9, 'iPhone', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 0, 1, NULL, 2, NULL), (8, 1, NULL, NULL, NULL, NULL), (-1, NULL, NULL, '2023-01-01', 1, NULL), (0, 0, 1, '2023-01-02', NULL, 2), (7, 0, 2, '2023-01-01', NULL, 1), (2, 1, NULL, '2023-01-02', NULL, 2), (NULL, 2, 1, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS A INNER JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT E.BUYER_ID FROM SALES AS E INNER JOIN PRODUCT AS F ON E.PRODUCT_ID = F.PRODUCT_ID WHERE F.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(None,)
*/