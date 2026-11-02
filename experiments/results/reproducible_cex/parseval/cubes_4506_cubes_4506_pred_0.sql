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
-- Inserting into table: staff --
INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483648, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483647, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483646, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483645, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483644, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483643, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483642, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483641, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483640, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483639, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483638, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483637, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483636, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483635, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483634, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483633, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483632, '6', 'sta_382df7');

INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (-2147483631, '6', 'sta_382df7');

-- Inserting into table: department_store_chain --
INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (-2147483648, 'dep_31ee1c');

-- Inserting into table: department_stores --
INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (-2147483648, -2147483648, 'dep_f4af8b', 'dep_facdb1', 'dep_07db8b', 'dep_3bffe9');

-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "dept_store_id", "department_name") VALUES (-2147483648, -2147483648, 'dep_f95b49');

-- Inserting into table: staff_department_assignments --
INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483648, -2147483648, '2024-06-15 00:00:00+00:00', 'sta_b0045f', '2024-12-15 00:56:33+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483647, -2147483648, '2024-06-15 00:00:00+00:00', 'sta_b0045f', '2024-02-19 01:18:26+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483646, -2147483648, '2024-06-15 00:00:00+00:00', 'sta_b0045f', '2023-01-16 20:10:41+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483645, -2147483648, NULL, 'sta_b0045f', '2020-10-31 07:51:16+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483644, -2147483648, NULL, 'sta_b0045f', '2024-11-14 12:35:58+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483643, -2147483648, NULL, 'sta_b0045f', '2025-02-21 23:30:13+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483642, -2147483648, '2024-06-15 00:00:00+00:00', NULL, '2024-01-16 07:29:50+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483641, -2147483648, '2024-06-15 00:00:00+00:00', NULL, '2025-11-08 19:01:33+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483640, -2147483648, '2024-06-15 00:00:00+00:00', NULL, '2020-09-25 19:25:33+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483639, -2147483648, '2024-06-15 00:00:00+00:00', 'sta_b0045f', '2025-06-13 15:31:02+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483638, -2147483648, '2024-06-15 00:00:00+00:00', 'sta_b0045f', '2021-02-21 20:09:01+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483637, -2147483648, '2024-06-15 00:00:00+00:00', 'sta_b0045f', '2023-03-21 21:13:18+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483636, -2147483648, '2024-06-15 00:00:00+00:00', 'sta_b0045f', '2023-05-25 17:04:36+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483635, -2147483648, '2024-06-15 00:00:00+00:00', 'sta_b0045f', '2025-08-22 00:34:24+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483634, -2147483648, '2024-06-15 00:00:00+00:00', 'sta_b0045f', '2020-04-05 14:43:51+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483633, -2147483648, '2024-06-15 00:00:00+00:00', 'sta_b0045f', '2024-04-12 00:38:47+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483632, -2147483648, '2024-06-15 00:00:00+00:00', 'sta_b0045f', '2020-12-19 01:52:21+00:00');

INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (-2147483631, -2147483648, '2024-06-15 00:00:00+00:00', 'sta_b0045f', '2021-07-11 07:27:32+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT minn AS department_id FROM (SELECT date_assigned_from, MIN(n) AS minn FROM (SELECT date_assigned_from, job_title_code, COUNT(*) AS n FROM staff_department_assignments GROUP BY date_assigned_from, job_title_code) GROUP BY date_assigned_from) ORDER BY department_id;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT department_id FROM staff_department_assignments GROUP BY department_id ORDER BY COUNT(*), department_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(-2147483648,)
*/