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
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (27, 'South46');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (26, 'South46');
INSERT INTO "Staff" ("staff_id", "staff_gender", "staff_name") VALUES (29, 'South46', 'South46');
INSERT INTO "Staff" ("staff_id", "staff_gender", "staff_name") VALUES (28, 'South46', 'South46');
INSERT INTO "Suppliers" ("supplier_id", "supplier_name", "supplier_phone") VALUES (30, 'South46', 'South46');
INSERT INTO "Department_Store_Chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (44, 'South');
INSERT INTO "Department_Store_Chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (50, 'South');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (31, 'South46', 'South46', 'South46', 'South46', 'South46', 'South46');
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (33, 'South46', 'South46', 46);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (32, 'South46', 'South46', 46);
INSERT INTO "Supplier_Addresses" ("supplier_id", "address_id", "date_from", "date_to") VALUES (30, 27, 46, 46);
INSERT INTO "Supplier_Addresses" ("supplier_id", "address_id", "date_from", "date_to") VALUES (30, 26, 46, 46);
INSERT INTO "Customer_Addresses" ("customer_id", "address_id", "date_from", "date_to") VALUES (31, 26, 46, 46);
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (34, 31, 'South46', 46);
INSERT INTO "Department_Stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (45, 44, 'South46', 'South47', 'South48', 'South49');
INSERT INTO "Department_Stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (51, 50, 'South46', 'South52', 'South53', 'South54');
INSERT INTO "Departments" ("department_id", "dept_store_id", "department_name") VALUES (35, 51, 'South46');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (37, 32, 34);
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (36, 32, 34);
INSERT INTO "Product_Suppliers" ("product_id", "supplier_id", "date_supplied_from", "date_supplied_to", "total_amount_purchased", "total_value_purchased") VALUES (33, 30, 46, 46, 'South46', 46);
INSERT INTO "Staff_Department_Assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (28, 35, 46, 'South46', 46);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "dept_store_chain_name", "store_name", COUNT(*) AS "n" FROM (SELECT "LHS"."dept_store_chain_id" AS "dept_store_chain_id", "LHS"."dept_store_chain_name" AS "dept_store_chain_name", "RHS"."dept_store_id" AS "dept_store_id", "RHS"."store_name" AS "store_name", "RHS"."store_address" AS "store_address", "RHS"."store_phone" AS "store_phone", "RHS"."store_email" AS "store_email" FROM "department_store_chain" AS "LHS" INNER JOIN "department_stores" AS "RHS" ON ("LHS"."dept_store_chain_id" = "RHS"."dept_store_chain_id")) GROUP BY "dept_store_chain_name", "store_name") WHERE ("dept_store_chain_name" = 'South') ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM department_stores AS T1 JOIN department_store_chain AS T2 ON T1.dept_store_chain_id = T2.dept_store_chain_id WHERE T2.dept_store_chain_name = 'South';

/*
Prediction Result:
(2,)
*/