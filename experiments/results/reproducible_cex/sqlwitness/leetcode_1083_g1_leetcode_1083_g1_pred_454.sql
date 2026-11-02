-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, NULL, NULL), (1, 'iPhone', NULL), (0, 'default2', 2), (2, 'default2', 1), (3, NULL, 2), (4, 'default2', 1), (5, NULL, 2), (6, 'iPhone', 1), (7, 'default2', 2), (8, NULL, 1), (9, NULL, 2), (10, NULL, NULL), (11, 'default1', NULL), (12, 'default2', 2), (13, 'S8', 1), (14, 'default2', 1), (15, 'default2', 2), (16, 'S8', 1), (17, 'S8', 2), (18, 'iPhone', 1), (19, 'S8', 2), (20, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (13, 0, 0, NULL, 2, 1), (19, 0, NULL, NULL, NULL, 2), (8, 1, 1, '2023-01-02', NULL, 2), (4, 0, NULL, '2023-01-01', 1, NULL), (5, 2, NULL, '2023-01-01', NULL, NULL), (2, 0, 1, '2023-01-01', 2, 1), (NULL, NULL, -1, '2023-01-02', NULL, NULL), (7, 2, 2, NULL, 2, NULL), (1, 1, NULL, '2023-01-02', 2, 1), (12, NULL, 2, NULL, 2, 2), (13, 2, -1, NULL, NULL, 2), (12, 0, 2, '2023-01-02', NULL, NULL), (1, 2, -1, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT SALES.BUYER_ID AS BUYER_IPHONE FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone'), CTE1 AS (SELECT DISTINCT SALES.BUYER_ID AS BUYER_S8 FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8') SELECT CTE1.BUYER_S8 AS BUYER_ID FROM CTE1 LEFT JOIN CTE ON CTE.BUYER_IPHONE = CTE1.BUYER_S8 WHERE BUYER_IPHONE IS NULL;

/*
Prediction Result:
(0,)
(None,)
*/