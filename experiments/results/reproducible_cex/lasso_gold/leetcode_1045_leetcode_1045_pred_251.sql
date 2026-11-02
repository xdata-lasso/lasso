-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_key") VALUES (1009);
INSERT INTO "product" ("product_key") VALUES (1012);
INSERT INTO "customer" ("product_key", "customer_id") VALUES (1009, 1010);
INSERT INTO "customer" ("product_key", "customer_id") VALUES (1009, 1011);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID FROM CUSTOMER GROUP BY 1 HAVING COUNT(DISTINCT PRODUCT_KEY) = (SELECT COUNT(DISTINCT PRODUCT_KEY) FROM CUSTOMER);

/*
Prediction Result:
(1010,)
(1011,)
*/