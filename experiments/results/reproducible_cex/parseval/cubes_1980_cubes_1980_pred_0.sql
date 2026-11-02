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
-- Inserting into table: department_store_chain --
INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (1, 'lhs_baf760');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (-2147483647, 'lhs_e4cca0');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (2, 'lhs_baf760');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (3, 'dep_31ee1c');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (4, 'dep_31ee1c');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (-2147483643, 'South');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (5, 'dep_31ee1c');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (-2147483641, 'South');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (6, 'dep_31ee1c');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (-2147483639, 'South');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (7, 'dep_31ee1c');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (-2147483637, 'South');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (8, 'dep_31ee1c');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (-2147483635, 'South');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (9, 'dep_31ee1c');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (-2147483633, 'South');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (10, 'dep_31ee1c');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (-2147483631, 'South');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (11, 'dep_31ee1c');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (-2147483629, 'South');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (12, 'dep_31ee1c');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (-2147483627, 'South');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (13, 'dep_31ee1c');

INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (-2147483625, 'South');

-- Inserting into table: department_stores --
INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (1, 1, 'rhs_5df8bb', 'rhs_736833', 'rhs_1615be', 'rhs_064bc1');

INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (-2147483647, 1, 'rhs_7fe861', 'rhs_92d59a', 'rhs_ea22fe', 'rhs_96431c');

INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (2, 1, 'rhs_5df8bb', 'rhs_736833', 'rhs_1615be', 'rhs_064bc1');

INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (3, 4, 'dep_f4af8b', 'dep_facdb1', 'dep_07db8b', 'dep_3bffe9');

INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (4, 5, 'dep_f4af8b', 'dep_facdb1', 'dep_07db8b', 'dep_3bffe9');

INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (5, 6, 'dep_f4af8b', 'dep_facdb1', 'dep_07db8b', 'dep_3bffe9');

INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (6, 7, 'dep_f4af8b', 'dep_facdb1', 'dep_07db8b', 'dep_3bffe9');

INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (7, 8, 'dep_f4af8b', 'dep_facdb1', 'dep_07db8b', 'dep_3bffe9');

INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (8, 9, 'dep_f4af8b', 'dep_facdb1', 'dep_07db8b', 'dep_3bffe9');

INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (9, 10, 'dep_f4af8b', 'dep_facdb1', 'dep_07db8b', 'dep_3bffe9');

INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (10, 11, 'dep_f4af8b', 'dep_facdb1', 'dep_07db8b', 'dep_3bffe9');

INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (11, 12, 'dep_f4af8b', 'dep_facdb1', 'dep_07db8b', 'dep_3bffe9');

INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (12, 13, 'dep_f4af8b', 'dep_facdb1', 'dep_07db8b', 'dep_3bffe9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "dept_store_chain_name", "store_name", COUNT(*) AS "n" FROM (SELECT "LHS"."dept_store_chain_id" AS "dept_store_chain_id", "LHS"."dept_store_chain_name" AS "dept_store_chain_name", "RHS"."dept_store_id" AS "dept_store_id", "RHS"."store_name" AS "store_name", "RHS"."store_address" AS "store_address", "RHS"."store_phone" AS "store_phone", "RHS"."store_email" AS "store_email" FROM "department_store_chain" AS "LHS" INNER JOIN "department_stores" AS "RHS" ON ("LHS"."dept_store_chain_id" = "RHS"."dept_store_chain_id")) GROUP BY "dept_store_chain_name", "store_name") WHERE ("dept_store_chain_name" = 'South') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM department_stores AS T1 JOIN department_store_chain AS T2 ON T1.dept_store_chain_id = T2.dept_store_chain_id WHERE T2.dept_store_chain_name = 'South';

/*
Prediction Result:
(0,)
*/