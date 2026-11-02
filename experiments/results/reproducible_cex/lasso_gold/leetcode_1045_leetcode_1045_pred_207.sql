-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_key") VALUES (1038);
INSERT INTO "product" ("product_key") VALUES (1028);
INSERT INTO "customer" ("product_key", "customer_id") VALUES (1038, 1039);
INSERT INTO "customer" ("product_key", "customer_id") VALUES (1028, 1039);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(1039,)
*/

-- Prediction Query
WITH PRODUCTS AS (SELECT GROUP_CONCAT(PRODUCT_KEY) AS PORDUCTS FROM PRODUCT), GROUPEDCUSTOMER AS (SELECT DISTINCT CUSTOMER_ID, PRODUCT_KEY FROM CUSTOMER) SELECT CUSTOMER_ID FROM GROUPEDCUSTOMER GROUP BY CUSTOMER_ID HAVING GROUP_CONCAT(PRODUCT_KEY) = (SELECT GROUP_CONCAT(PRODUCT_KEY) AS PORDUCTS FROM PRODUCT);

/*
Prediction Result:
*/