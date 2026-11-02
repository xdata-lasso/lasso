-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', 2), (1, 'S8', 1), (-1, 'S8', 2), (0, 'S8', 2), (3, NULL, 2), (4, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, -1, -1, '2023-01-02', 1, 1), (-1, -1, 0, '2023-01-02', 1, 2), (0, 0, NULL, '2023-01-02', 1, 1), (4, 1, 1, NULL, 2, 1), (2, -1, 1, NULL, 1, NULL), (NULL, -1, 0, NULL, 2, 2), (2, 2, -1, '2023-01-02', 2, NULL), (NULL, NULL, 0, '2023-01-02', 1, 2), (3, NULL, 1, NULL, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(0,)
(1,)
*/

-- Prediction Query
SELECT SUB.BUYER_ID FROM (SELECT A.BUYER_ID, SUM(S8_IND) AS S8_IND, SUM(IPHONE_IND) AS IPHONE_IND FROM SALES AS A LEFT JOIN (SELECT PRODUCT_ID, CASE WHEN PRODUCT_NAME IN ('S8') THEN 1 ELSE 0 END AS S8_IND, CASE WHEN PRODUCT_NAME IN ('iPhone') THEN 1 ELSE 0 END AS IPHONE_IND FROM PRODUCT) AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY A.BUYER_ID) AS SUB WHERE S8_IND >= 1 AND IPHONE_IND <= 0 GROUP BY SUB.BUYER_ID;

/*
Prediction Result:
(None,)
(-1,)
(0,)
(1,)
*/