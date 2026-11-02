-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default1', NULL), (-1, NULL, 1), (0, '2019-01-01', 2), (1, NULL, 1), (3, '2019-01-01', 2), (4, '2019-03-31', 1), (5, '2019-03-31', 2), (6, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 2, 1, '2023-01-02', 2, 1), (4, -1, -1, '2019-03-30', NULL, 1), (6, -1, -1, '2023-01-01', 2, NULL), (4, 1, -1, NULL, 2, 1), (2, 2, 2, '2023-01-01', 1, 1), (4, 1, 0, '2019-03-31', 2, 2), (6, 0, 1, '2019-03-31', NULL, 2), (NULL, 2, NULL, '2023-01-02', 2, 2), (0, 0, 2, '2019-03-31', 1, 2), (NULL, 2, -1, '2018-12-31', 2, 1), (3, 1, 2, '2019-03-30', NULL, 1), (5, 1, 2, '2019-03-31', 2, NULL), (-1, 0, 0, '2019-01-02', 2, NULL), (5, NULL, 0, '2023-01-01', NULL, 2), (4, 0, -1, '2023-01-01', NULL, NULL), (3, 0, 0, '2019-03-30', NULL, 2), (2, 1, NULL, '2018-12-31', NULL, 1), (0, -1, 2, '2023-01-02', 2, 2), (2, 1, 0, '2019-01-02', 2, 2), (3, 0, NULL, '2023-01-02', 1, 2), (2, 1, 0, NULL, 2, 1), (1, 2, 1, NULL, 2, 2), (5, -1, 0, '2019-01-02', 2, 1), (4, 0, 0, '2023-01-01', 2, NULL), (-1, 1, 2, '2019-04-01', 2, 1), (6, -1, 2, '2019-03-30', NULL, 1), (-1, NULL, NULL, '2023-01-02', 1, NULL), (NULL, NULL, -1, '2023-01-02', 1, 1), (NULL, NULL, 2, NULL, 1, 2), (4, 0, NULL, '2019-01-01', NULL, 1), (-1, -1, 2, NULL, 1, 2), (1, 1, 1, '2019-01-01', 2, 1), (6, NULL, 0, '2019-01-02', 2, NULL), (3, NULL, 2, '2019-01-01', 2, 2), (0, 0, 0, '2019-01-02', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
SELECT P.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S USING (PRODUCT_ID) WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') GROUP BY 1;

/*
Prediction Result:
*/