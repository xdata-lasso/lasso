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
INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (1001, 'Allison Hill');
INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (1002, 'Noah Rhodes');
INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (1003, 'Angie Henderson');
INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (1004, 'all', 'Lance Hoffman');
INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (1005, 'better', 'Meredith Barnes');
INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (1006, 'discover', 'Donald Booth');
INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (1007, 1001, 'Caitlin Henderson', '78161 Calderon River Suite 931
Lake Jeremyport, CO 31013', '837-767-2423x88496', 'shawnmckay@example.net');
INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (1008, 1001, 'Daniel Gallagher', '7525 Clark Grove Apt. 928
East Steven, KY 84387', '828.371.0122', 'teresa28@example.org');
INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (1009, 1001, 'James Howard', '503 Linda Locks
Carlshire, FM 94599', '(669)878-4801x8451', 'meagan89@example.org');
INSERT INTO "departments" ("department_id", "dept_store_id", "department_name") VALUES (1010, 1007, 'Phillip Ryan');
INSERT INTO "departments" ("department_id", "dept_store_id", "department_name") VALUES (1011, 1007, 'Kerry Smith');
INSERT INTO "departments" ("department_id", "dept_store_id", "department_name") VALUES (1012, 1007, 'Alec Hickman');
INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (1004, 1010, '1970-01-01', 'Information systems manager', '1973-04-04');
INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (1004, 1011, '1970-01-02', 'Film/video editor', '1973-04-05');
INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (1004, 1012, '1970-01-03', 'Barrister', '1973-04-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "staff_id" FROM (SELECT "staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to", MAX("date_assigned_to") OVER () AS "maxdate_assigned_to" FROM "staff_department_assignments") WHERE ("job_title_code" <> 'Clerical Staff' OR maxdate_assigned_to > date_assigned_to) ORDER BY staff_id, "staff_id" NULLS LAST;

/*
Gold Result:
(1004,)
(1004,)
(1004,)
*/

-- Prediction Query
SELECT staff_id FROM Staff_Department_Assignments WHERE date_assigned_to < (SELECT MAX(date_assigned_to) FROM Staff_Department_Assignments WHERE job_title_code = 'Clerical Staff');

/*
Prediction Result:
*/