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
-- DATASET 1
-- Tests standard join condition vs FK join condition, WHERE predicates, and OUTER JOIN mutations.
INSERT INTO "Department_Store_Chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (10, 'Chain Alpha');
INSERT INTO "Department_Store_Chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (20, 'Chain Beta');
INSERT INTO "Department_Store_Chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (30, 'Chain Gamma');
INSERT INTO "Department_Stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (1, 20, 'Store One', '123 Main', '111-2222', 's1@example.com');
INSERT INTO "Department_Stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (2, 10, 'Store Two', '456 Oak', '333-4444', 's2@example.com');
INSERT INTO "Department_Stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (3, 30, 'Store Three', '789 Pine', '555-6666', 's3@example.com');
INSERT INTO "Department_Stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (4, 10, 'Store Four', '101 Maple', '777-8888', 's4@example.com');
-- Matches Gold Join (LHS.dept_store_id = RHS.department_id -> 1 = 1), but FK points to Store 2.
INSERT INTO "Departments" ("department_id", "dept_store_id", "department_name") VALUES (1, 2, 'marketing');
-- Matches FK Join (RHS.dept_store_id = 1), but department_id = 99 (unmatched in Gold Join).
INSERT INTO "Departments" ("department_id", "dept_store_id", "department_name") VALUES (99, 1, 'marketing');
-- Matches Gold Join ID (2 = 2), but department_name is 'managing' (tests WHERE predicate mutations).
INSERT INTO "Departments" ("department_id", "dept_store_id", "department_name") VALUES (2, 2, 'managing');
-- Matches Gold Join ID (3 = 3), but department_name is 'sales' (tests <> 'managing' alone).
INSERT INTO "Departments" ("department_id", "dept_store_id", "department_name") VALUES (3, 3, 'sales');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dept_store_chain_id" AS "dept_store_id", "store_name" FROM (SELECT "LHS"."dept_store_id" AS "dept_store_id", "LHS"."dept_store_chain_id" AS "dept_store_chain_id", "LHS"."store_name" AS "store_name", "LHS"."store_address" AS "store_address", "LHS"."store_phone" AS "store_phone", "LHS"."store_email" AS "store_email", "RHS"."dept_store_id" AS "dept_store_id_other", "RHS"."department_name" AS "department_name" FROM "department_stores" AS "LHS" INNER JOIN (SELECT * FROM "departments" WHERE ("department_name" = 'marketing' AND "department_name" <> 'managing')) AS RHS ON (LHS.dept_store_id = RHS.department_id)) ORDER BY dept_store_id, "store_name" NULLS LAST;

/*
Gold Result:
(20, 'Store One')
*/

-- Prediction Query
SELECT T2.dept_store_id, T2.store_name FROM departments AS T1 JOIN department_stores AS T2 ON T1.dept_store_id = T2.dept_store_id WHERE T1.department_name = 'marketing' INTERSECT SELECT T2.dept_store_id, T2.store_name FROM departments AS T1 JOIN department_stores AS T2 ON T1.dept_store_id = T2.dept_store_id WHERE T1.department_name = 'managing';

/*
Prediction Result:
(2, 'Store Two')
*/