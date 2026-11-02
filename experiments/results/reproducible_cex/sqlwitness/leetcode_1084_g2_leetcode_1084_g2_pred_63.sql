-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 1), (-1, 'default2', 3), (3, '2019-03-31', NULL), (2, '2019-01-01', NULL), (1, '2019-03-31', 1), (4, '2019-01-01', 3);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, NULL, NULL, '2023-01-02', 2, 3), (3, 2, 0, '2019-03-30', 1, NULL), (-1, 2, -1, '2018-12-31', NULL, 1), (NULL, 1, -1, '2019-03-31', 3, 1), (3, NULL, 1, '2019-01-01', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(3, '2019-03-31')
*/

-- Prediction Query
SELECT P.PRODUCT_NAME, P.PRODUCT_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE S.SALE_DATE BETWEEN ' 2019-01-01 ' AND '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') GROUP BY 1, 2;

/*
Prediction Result:
('2019-03-31', 3)
*/