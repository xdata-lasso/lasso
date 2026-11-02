-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "address_content" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50), "other_address_details" TEXT(255));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method" TEXT(15), "customer_name" TEXT(80), "date_became_customer" DATETIME, "other_customer_details" TEXT(255));

CREATE TABLE "Customer_Addresses" ("customer_id" INTEGER, "address_id" INTEGER, "date_address_from" DATETIME, "address_type" TEXT(15), "date_address_to" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Contact_Channels" ("customer_id" INTEGER, "channel_code" TEXT(15), "active_from_date" DATETIME, "active_to_date" DATETIME, "contact_number" TEXT(50), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_status" TEXT(15), "order_date" DATETIME, "order_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "order_quantity" TEXT(15), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Products" ("product_id", "product_details") VALUES (1, 'Product A');
INSERT INTO "Products" ("product_id", "product_details") VALUES (2, 'Product B');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1, 'Cash', 'John Doe', '2023-01-01', 'None');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (1, 1, 'Completed', '2023-01-02', 'None');
INSERT INTO "Order_Items" ("order_id", "product_id", "order_quantity") VALUES (1, 1, '10');
INSERT INTO "Order_Items" ("order_id", "product_id", "order_quantity") VALUES (1, 2, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_details, product_id FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.product_id AS product_id, LHS.product_details AS product_details, RHS.order_id AS order_id, RHS.order_quantity AS order_quantity FROM products AS LHS INNER JOIN order_items AS RHS ON (LHS.product_id = RHS.product_id)) ORDER BY product_id) LIMIT 1);

/*
Gold Result:
('Product A', 1)
*/

-- Prediction Query
SELECT t2.product_details, t2.product_id FROM order_items AS t1 JOIN products AS t2 ON t1.product_id = t2.product_id GROUP BY t1.product_id ORDER BY SUM(t1.order_quantity), t2.product_details NULLS LAST, t2.product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Product B', 2)
*/