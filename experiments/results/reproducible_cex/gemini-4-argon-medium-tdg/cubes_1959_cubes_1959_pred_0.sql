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
-- DATASET 2
INSERT INTO "Department_Store_Chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (1, 'Chain A');
INSERT INTO "Department_Stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (1, 1, 'Store 1', '123 Main St', '555-0100', 'store1@chain.com');
INSERT INTO "Departments" ("department_id", "dept_store_id", "department_name") VALUES (101, 1, 'Home');
INSERT INTO "Departments" ("department_id", "dept_store_id", "department_name") VALUES (102, 1, 'Garden');
INSERT INTO "Departments" ("department_id", "dept_store_id", "department_name") VALUES (103, 1, 'Toys');
INSERT INTO "Staff" ("staff_id", "staff_gender", "staff_name") VALUES (5, 'M', 'Evan');
INSERT INTO "Staff" ("staff_id", "staff_gender", "staff_name") VALUES (10, 'F', 'Fiona');
INSERT INTO "Staff" ("staff_id", "staff_gender", "staff_name") VALUES (15, 'M', 'George');
INSERT INTO "Staff_Department_Assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (15, 101, '2019-05-01', 'Department Manager', '2022-05-01');
INSERT INTO "Staff_Department_Assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (5, 101, '2019-06-01', 'Department Manager', '2022-06-01');
INSERT INTO "Staff_Department_Assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (5, 102, '2020-01-01', 'Department Manager', '2023-01-01');
INSERT INTO "Staff_Department_Assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (10, 103, '2021-03-01', 'Clerk', '2023-03-01');
INSERT INTO "Staff_Department_Assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (10, 101, '2021-04-01', NULL, '2023-04-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "staff_id", "staff_gender" FROM (SELECT "LHS"."staff_id" AS "staff_id", "LHS"."department_id" AS "department_id", "LHS"."date_assigned_from" AS "date_assigned_from", "LHS"."job_title_code" AS "job_title_code", "LHS"."date_assigned_to" AS "date_assigned_to", "RHS"."staff_gender" AS "staff_gender", "RHS"."staff_name" AS "staff_name" FROM "staff_department_assignments" AS "LHS" LEFT JOIN "staff" AS "RHS" ON ("LHS"."staff_id" = "RHS"."staff_id")) WHERE ("job_title_code" = 'Department Manager') ORDER BY staff_id, "staff_id" NULLS LAST, "staff_gender" NULLS LAST;

/*
Gold Result:
(5, 'M')
(5, 'M')
(15, 'M')
*/

-- Prediction Query
SELECT T1.staff_id, T1.staff_gender FROM staff AS T1 JOIN staff_department_assignments AS T2 ON T1.staff_id = T2.staff_id WHERE T2.job_title_code = 'Department Manager';

/*
Prediction Result:
(15, 'M')
(5, 'M')
(5, 'M')
*/