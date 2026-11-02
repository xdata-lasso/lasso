-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_type_code" TEXT(15), "product_name" TEXT(80), "product_price" REAL);

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method_code" TEXT(15), "customer_number" TEXT(20), "customer_name" TEXT(80), "customer_address" TEXT(255), "customer_phone" TEXT(80), "customer_email" TEXT(80));

CREATE TABLE "Contacts" ("contact_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(50), "contact_phone" TEXT(80));

CREATE TABLE "Customer_Address_History" ("address_id" INTEGER, "customer_id" INTEGER, "date_from" DATETIME, "date_to" DATETIME, FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATETIME, "order_status_code" TEXT(15), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "order_item_id" INTEGER, "order_quantity" TEXT(80), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1001, 'purpose', 'Patrick Sanchez', 1002.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT product_type_code FROM (SELECT product_id, product_type_code, COUNT(*) AS n FROM (SELECT LHS.product_id AS product_id, LHS.product_type_code AS product_type_code, LHS.product_name AS product_name, LHS.product_price AS product_price, RHS.product_type_code AS product_type_code_other, RHS.product_name AS product_name_other FROM products AS LHS INNER JOIN products AS RHS ON (LHS.product_id = RHS.product_id AND LHS.product_price = RHS.product_price)) GROUP BY product_id, product_type_code) ORDER BY product_type_code;

/*
Gold Result:
('purpose',)
*/

-- Prediction Query
SELECT product_type_code FROM products GROUP BY product_type_code HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/