-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (10, 14);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (10, 13);
INSERT INTO "Product" ("product_key") VALUES (10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(13,)
(14,)
*/

-- Prediction Query
SELECT C.CUSTOMER_ID FROM CUSTOMER AS C LEFT JOIN PRODUCT AS P ON C.PRODUCT_KEY = P.PRODUCT_KEY GROUP BY C.CUSTOMER_ID HAVING COUNT(DISTINCT C.PRODUCT_KEY) = (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
(13,)
(14,)
*/