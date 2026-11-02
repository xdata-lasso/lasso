-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', NULL), (1, '%IPHONE%', NULL), (2, 'default2', NULL), (3, '%S8%', 1), (4, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, NULL, NULL, 1, 1), (1, 1, NULL, '2023-01-01', NULL, NULL), (2, NULL, 1, '2023-01-01', 1, NULL), (2, 0, 1, '2023-01-02', NULL, NULL), (4, 1, NULL, '2023-01-02', NULL, NULL), (NULL, NULL, 0, '2023-01-02', 1, 1), (4, 1, 0, NULL, NULL, 1), (NULL, 0, NULL, '2023-01-01', NULL, NULL), (0, 0, NULL, NULL, NULL, 1), (NULL, NULL, NULL, '2023-01-01', 1, 1), (1, NULL, NULL, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
(0,)
*/

-- Prediction Query
SELECT A.BUYER_ID FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY A.BUYER_ID HAVING GROUP_CONCAT(DISTINCT PRODUCT_NAME) LIKE '%S8%' AND GROUP_CONCAT(DISTINCT PRODUCT_NAME) NOT LIKE '%IPHONE%';

/*
Prediction Result:
(0,)
*/