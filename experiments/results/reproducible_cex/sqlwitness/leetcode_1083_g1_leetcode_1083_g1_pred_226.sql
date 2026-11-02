-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'iPhone', 1), (1, 'S8', 2), (-1, 'S8', 2), (0, 'S8', 1), (3, 'default2', 2), (4, 'iPhone', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, -1, '2023-01-02', 1, 2), (1, 0, 2, '2023-01-02', 1, NULL), (0, 1, 2, '2023-01-01', 2, 1), (4, NULL, 2, '2023-01-02', 1, 2), (0, 0, 1, '2023-01-02', NULL, 2), (3, NULL, -1, '2023-01-01', 2, 2), (NULL, 1, 1, '2023-01-02', NULL, 2), (0, 2, NULL, NULL, 2, NULL), (2, 0, 1, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
WITH REFINED_PRODUCT AS (SELECT PRODUCT_ID, PRODUCT_NAME, CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END AS S8_SALE, CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END AS IPHONE_SALE FROM PRODUCT WHERE PRODUCT_NAME IN ('S8', 'iPhone')) SELECT BUYER_ID FROM SALES JOIN REFINED_PRODUCT USING (PRODUCT_ID) GROUP BY 1 HAVING SUM(IPHONE_SALE) = 0 AND SUM(S8_SALE) > 0;

/*
Prediction Result:
(None,)
(-1,)
*/