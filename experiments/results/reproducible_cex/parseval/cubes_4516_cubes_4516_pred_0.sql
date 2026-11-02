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
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (-2147483648, 'cus_ac066f', 'cus_5a0f54', 'cus_8d1b6b', 'cus_6602b7', 'cus_a818b6', 'cus_14971e');

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483648, 'pro_00ee80', 'pro_bf129f', 0.0001);

-- Inserting into table: customer_orders --
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (-2147483648, -2147483648, 'cus_b45c2b', '2024-12-15 00:56:33+00:00');

INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (1, -2147483648, 'cus_b45c2b', '2024-02-19 01:18:26+00:00');

-- Inserting into table: order_items --
INSERT INTO "order_items" ("order_item_id", "product_id", "order_id") VALUES (1, -2147483648, -2147483648);

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id") VALUES (-2147483647, -2147483648, -2147483648);

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id") VALUES (2, -2147483648, -2147483648);

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id") VALUES (3, -2147483648, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_item_id_other AS product_id FROM (SELECT order_item_id AS order_id, order_item_id, n, order_item_id_other FROM (SELECT LHS.order_id AS order_id, LHS.order_item_id AS order_item_id, LHS.n AS n, RHS.order_item_id AS order_item_id_other FROM (SELECT order_id, order_item_id, MAX(n) AS n FROM (SELECT order_id, order_item_id, COUNT(*) AS n FROM order_items GROUP BY order_id, order_item_id) GROUP BY order_id, order_item_id) AS LHS INNER JOIN order_items AS RHS ON (LHS.order_item_id = RHS.order_id AND LHS.order_id = RHS.product_id))) ORDER BY product_id;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT product_id FROM order_items GROUP BY product_id ORDER BY COUNT(*) DESC, product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(-2147483648,)
*/