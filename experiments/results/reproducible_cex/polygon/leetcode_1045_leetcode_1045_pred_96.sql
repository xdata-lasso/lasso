-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 16);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(16,)
*/

-- Prediction Query
WITH A AS (SELECT DISTINCT CUSTOMER_ID, PRODUCT.PRODUCT_KEY FROM CUSTOMER CROSS JOIN PRODUCT) SELECT DISTINCT A.CUSTOMER_ID FROM A WHERE NOT A.CUSTOMER_ID IN (SELECT A.CUSTOMER_ID FROM A LEFT JOIN CUSTOMER ON A.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID AND A.PRODUCT_KEY = CUSTOMER.PRODUCT_KEY WHERE CUSTOMER.PRODUCT_KEY IS NULL);

/*
Prediction Result:
*/