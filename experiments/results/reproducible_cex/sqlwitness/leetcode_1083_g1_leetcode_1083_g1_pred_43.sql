-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', NULL), (1, 'S8', NULL), (0, 'S8', 1), (-1, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 0, NULL, NULL, 2, NULL), (-1, 1, 0, '2023-01-02', 1, 1), (-1, 0, 1, NULL, 1, 1), (0, -1, 1, '2023-01-01', 2, NULL), (2, 2, 1, '2023-01-02', NULL, NULL), (1, 1, 1, '2023-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT S.BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.BUYER_ID HAVING SUM(P.PRODUCT_NAME = 'S8') > 0 AND SUM(P.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
*/