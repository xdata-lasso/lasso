-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "address_details" TEXT(255));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_gender" TEXT(1), "staff_name" TEXT(80));

CREATE TABLE "Suppliers" ("supplier_id" INTEGER PRIMARY KEY, "supplier_name" TEXT(80), "supplier_phone" TEXT(80));

CREATE TABLE "Department_Store_Chain" ("dept_store_chain_id" INTEGER PRIMARY KEY, "dept_store_chain_name" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method_code" TEXT(10), "customer_code" TEXT(20), "customer_name" TEXT(80), "customer_address" TEXT(255), "customer_phone" TEXT(80), "customer_email" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_type_code" TEXT(10), "product_name" TEXT(80), "product_price" REAL(19, 4));

CREATE TABLE "Supplier_Addresses" ("supplier_id" INTEGER, "address_id" INTEGER, "date_from" DATETIME, "date_to" DATETIME, PRIMARY KEY ("supplier_id", "address_id"), FOREIGN KEY ("supplier_id") REFERENCES "Suppliers" ("supplier_id"), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Addresses" ("customer_id" INTEGER, "address_id" INTEGER, "date_from" DATETIME, "date_to" DATETIME, PRIMARY KEY ("customer_id", "address_id"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_status_code" TEXT(10), "order_date" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Department_Stores" ("dept_store_id" INTEGER PRIMARY KEY, "dept_store_chain_id" INTEGER, "store_name" TEXT(80), "store_address" TEXT(255), "store_phone" TEXT(80), "store_email" TEXT(80), FOREIGN KEY ("dept_store_chain_id") REFERENCES "Department_Store_Chain" ("dept_store_chain_id"));

CREATE TABLE "Departments" ("department_id" INTEGER PRIMARY KEY, "dept_store_id" INTEGER, "department_name" TEXT(80), FOREIGN KEY ("dept_store_id") REFERENCES "Department_Stores" ("dept_store_id"));

CREATE TABLE "Order_Items" ("order_item_id" INTEGER PRIMARY KEY, "product_id" INTEGER, "order_id" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"));

CREATE TABLE "Product_Suppliers" ("product_id" INTEGER, "supplier_id" INTEGER, "date_supplied_from" DATETIME, "date_supplied_to" DATETIME, "total_amount_purchased" TEXT(80), "total_value_purchased" REAL(19, 4), PRIMARY KEY ("product_id", "supplier_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("supplier_id") REFERENCES "Suppliers" ("supplier_id"));

CREATE TABLE "Staff_Department_Assignments" ("staff_id" INTEGER, "department_id" INTEGER, "date_assigned_from" DATETIME, "job_title_code" TEXT(10), "date_assigned_to" DATETIME, PRIMARY KEY ("staff_id", "department_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("department_id") REFERENCES "Departments" ("department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483648, 'pro_00ee80', 'pro_bf129f', 1.0);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483647, 'pro_00ee80', 'pro_bf129f', 7719.0);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1, 'rhs_c0a0a5', 'rhs_cdc982', 0.0);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483645, 'pro_00ee80', 'pro_bf129f', 1.0);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483644, 'pro_00ee80', 'pro_bf129f', 1.0);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483643, 'pro_00ee80', 'pro_bf129f', 7719.0);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483642, 'pro_00ee80', 'pro_bf129f', 7719.0);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483641, 'pro_00ee80', 'pro_bf129f', 1.0);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483640, 'pro_00ee80', 'pro_bf129f', NULL);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483639, 'pro_00ee80', 'pro_bf129f', NULL);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483638, 'pro_00ee80', NULL, 1.0);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483637, 'pro_00ee80', NULL, NULL);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483636, 'pro_00ee80', NULL, 21238.0);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483635, 'pro_00ee80', 'pro_bf129f', NULL);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483634, 'pro_00ee80', 'pro_bf129f', NULL);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483633, 'pro_00ee80', 'pro_bf129f', NULL);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483632, NULL, 'pro_bf129f', 1.0);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483631, NULL, 'pro_bf129f', NULL);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483630, NULL, 'pro_bf129f', 21238.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, product_type_code FROM (SELECT LHS.product_price AS product_price, RHS.product_id AS product_id, RHS.product_type_code AS product_type_code, RHS.product_name AS product_name, RHS.product_price AS product_price_other FROM (SELECT MIN(product_price) AS product_price FROM products) AS LHS CROSS JOIN products AS RHS) WHERE (product_price >= product_price_other) ORDER BY product_id, product_type_code NULLS LAST;

/*
Gold Result:
(1, 'rhs_c0a0a5')
*/

-- Prediction Query
SELECT product_id, product_type_code FROM products ORDER BY product_price, products.product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(-2147483640, 'pro_00ee80')
*/