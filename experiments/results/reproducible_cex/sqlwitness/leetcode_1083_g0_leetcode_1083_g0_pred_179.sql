-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', 1), (1, 'default1', NULL), (2, 'default1', NULL), (3, 'default1', 1), (4, 'S8', NULL), (5, NULL, NULL), (6, 'S8', 1), (7, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 0, 1, '2023-01-01', NULL, 1), (6, NULL, 1, '2023-01-02', NULL, NULL), (7, 0, 1, '2023-01-01', 1, 1), (1, 1, NULL, '2023-01-02', 1, NULL), (NULL, NULL, NULL, NULL, NULL, NULL), (7, 0, NULL, '2023-01-02', 1, NULL), (1, 1, 0, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT S.BUYER_ID FROM SALES AS S WHERE S.PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8') AND NOT S.BUYER_ID IN (SELECT DISTINCT SS.BUYER_ID FROM SALES AS SS CROSS JOIN PRODUCT AS P WHERE P.PRODUCT_NAME = 'iPhone' AND P.PRODUCT_ID = SS.PRODUCT_ID);

/*
Prediction Result:
*/