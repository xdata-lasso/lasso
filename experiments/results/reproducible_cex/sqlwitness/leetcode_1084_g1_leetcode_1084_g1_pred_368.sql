-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', NULL), (1, NULL, NULL), (2, 'default2', NULL), (3, 'default2', NULL), (4, 'default2', NULL), (5, '2019-03-31', NULL), (6, 'default2', NULL), (7, 'default2', NULL), (8, NULL, NULL), (9, NULL, NULL), (10, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, 1, '2023-01-02', 1, 1), (2, 0, NULL, '2023-01-01', 1, 1), (1, NULL, 1, NULL, NULL, 1), (5, 1, 0, '2019-03-30', 1, 1), (2, NULL, 0, '2019-03-30', NULL, NULL), (6, NULL, NULL, '2019-03-31', 1, 1), (2, 0, 0, '2019-03-31', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(1, None)
(5, '2019-03-31')
*/

-- Prediction Query
WITH TABLE_FINAL AS (SELECT A.PRODUCT_ID, PRODUCT_NAME, SALE_DATE FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID) SELECT DISTINCT PRODUCT_ID, PRODUCT_NAME FROM TABLE_FINAL WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM TABLE_FINAL WHERE '2019-01-01' <= SALE_DATE <= '2019-03-31') AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM TABLE_FINAL WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(5, '2019-03-31')
*/