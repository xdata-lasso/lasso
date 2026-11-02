-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, 2), (2, 'S8', 2), (0, 'default2', 1), (-1, 'S8', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT S1.BUYER_ID FROM PRODUCT AS P1 LEFT JOIN SALES AS S1 ON P1.PRODUCT_ID = S1.PRODUCT_ID WHERE P1.PRODUCT_NAME = 'S8' AND NOT S1.BUYER_ID IN (SELECT DISTINCT S1.BUYER_ID FROM PRODUCT AS P1 LEFT JOIN SALES AS S1 ON P1.PRODUCT_ID = S1.PRODUCT_ID WHERE P1.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(None,)
*/