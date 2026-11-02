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
INSERT INTO "customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (1001, 'purpose', 'brother', 'Donald Walker', '600 Jeffery Parkways
New Jamesside, MT 29394', '394.802.6542x351', 'howardmaurice@example.com');
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1002, 'surface', 'Calvin Nielsen', 1005.5);
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1003, 'animal', 'Edward Fuller', 1014.5);
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1004, 'show', 'Heidi Lee', 1023.5);
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (1008, 1001, 'available', '1970-01-01');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (1009, 1001, 'answer', '1970-01-02');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (1010, 1001, 'recently', '1970-01-03');
INSERT INTO "order_items" ("order_item_id", "product_id", "order_id") VALUES (1013, 1002, 1008);
INSERT INTO "order_items" ("order_item_id", "product_id", "order_id") VALUES (1014, 1002, 1008);
INSERT INTO "order_items" ("order_item_id", "product_id", "order_id") VALUES (1015, 1002, 1008);
INSERT INTO "order_items" ("order_item_id", "product_id", "order_id") VALUES (1016, 1002, 1008);
INSERT INTO "order_items" ("order_item_id", "product_id", "order_id") VALUES (1017, 1002, 1008);
INSERT INTO "order_items" ("order_item_id", "product_id", "order_id") VALUES (1018, 1002, 1008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT product_id FROM (SELECT LHS.order_id AS order_id, LHS.product_id AS product_id, LHS.n AS n, RHS.order_id AS order_id_other, RHS.product_id AS product_id_other, RHS.n AS n_other FROM (SELECT order_id, product_id, COUNT(*) AS n FROM order_items GROUP BY order_id, product_id) AS LHS CROSS JOIN (SELECT order_id, product_id, COUNT(*) AS n FROM order_items GROUP BY order_id, product_id) AS RHS) WHERE (n > n_other) ORDER BY product_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT product_id FROM order_items GROUP BY product_id ORDER BY COUNT(*) DESC, product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1002,)
*/