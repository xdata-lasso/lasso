-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', NULL), (0, 'S8', 1), (-1, NULL, 1), (2, 'S8', 1), (3, 'default1', 1), (4, 'iPhone', 2), (5, 'iPhone', NULL), (6, 'default1', 1), (7, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, -1, 0, '2023-01-02', 2, NULL), (3, 1, NULL, NULL, 2, 2), (5, -1, 1, NULL, 2, 2), (2, 2, NULL, NULL, 1, NULL), (2, -1, NULL, NULL, NULL, NULL), (1, -1, 2, '2023-01-02', 2, NULL), (6, 1, 2, '2023-01-01', NULL, 2), (5, -1, NULL, '2023-01-01', 2, NULL), (-1, NULL, NULL, '2023-01-01', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT S.BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT EXISTS(SELECT 1 FROM SALES AS S2 INNER JOIN PRODUCT AS P2 ON P2.PRODUCT_ID = S2.PRODUCT_ID WHERE P2.PRODUCT_NAME = 'iPhone' AND S2.BUYER_ID = S.BUYER_ID);

/*
Prediction Result:
(None,)
*/