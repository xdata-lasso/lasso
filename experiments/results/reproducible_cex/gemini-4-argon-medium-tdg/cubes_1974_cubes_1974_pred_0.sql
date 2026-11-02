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
-- Tests DISTINCT / GROUP BY mutants (same supplier supplying multiple distinct 'red jeans' products, and multiple suppliers with identical name and phone)
INSERT INTO "Suppliers" ("supplier_id", "supplier_name", "supplier_phone") VALUES (1, 'Dup Supplier', '555-0199');
INSERT INTO "Suppliers" ("supplier_id", "supplier_name", "supplier_phone") VALUES (2, 'Dup Supplier', '555-0199');
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (101, 'C1', 'red jeans', 30.00);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (102, 'C2', 'red jeans', 40.00);
INSERT INTO "Product_Suppliers" ("product_id", "supplier_id", "date_supplied_from", "date_supplied_to", "total_amount_purchased", "total_value_purchased") VALUES (101, 1, '2022-01-01', '2022-12-31', '10', 300.00);
INSERT INTO "Product_Suppliers" ("product_id", "supplier_id", "date_supplied_from", "date_supplied_to", "total_amount_purchased", "total_value_purchased") VALUES (102, 1, '2022-01-01', '2022-12-31', '20', 800.00);
INSERT INTO "Product_Suppliers" ("product_id", "supplier_id", "date_supplied_from", "date_supplied_to", "total_amount_purchased", "total_value_purchased") VALUES (101, 2, '2022-01-01', '2022-12-31', '15', 450.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "supplier_name", "supplier_phone" FROM (SELECT "LHS"."supplier_id" AS "supplier_id", "LHS"."supplier_name" AS "supplier_name", "LHS"."supplier_phone" AS "supplier_phone", "LHS"."product_id" AS "product_id", "LHS"."date_supplied_from" AS "date_supplied_from", "LHS"."date_supplied_to" AS "date_supplied_to", "LHS"."total_amount_purchased" AS "total_amount_purchased", "LHS"."total_value_purchased" AS "total_value_purchased", "RHS"."product_type_code" AS "product_type_code", "RHS"."product_name" AS "product_name", "RHS"."product_price" AS "product_price" FROM (SELECT "LHS"."supplier_id" AS "supplier_id", "LHS"."supplier_name" AS "supplier_name", "LHS"."supplier_phone" AS "supplier_phone", "RHS"."product_id" AS "product_id", "RHS"."date_supplied_from" AS "date_supplied_from", "RHS"."date_supplied_to" AS "date_supplied_to", "RHS"."total_amount_purchased" AS "total_amount_purchased", "RHS"."total_value_purchased" AS "total_value_purchased" FROM "suppliers" AS "LHS" INNER JOIN "product_suppliers" AS "RHS" ON ("LHS"."supplier_id" = "RHS"."supplier_id")) AS "LHS" INNER JOIN (SELECT * FROM "products" WHERE ("product_name" = 'red jeans')) AS RHS ON (LHS.product_id = RHS.product_id)) ORDER BY supplier_name, "supplier_name" NULLS LAST, "supplier_phone" NULLS LAST;

/*
Gold Result:
('Dup Supplier', '555-0199')
('Dup Supplier', '555-0199')
('Dup Supplier', '555-0199')
*/

-- Prediction Query
SELECT DISTINCT T1.supplier_name, T1.supplier_phone FROM suppliers AS T1 JOIN product_suppliers AS T2 ON T1.supplier_id = T2.supplier_id JOIN products AS T3 ON T2.product_id = T3.product_id WHERE T3.product_name = 'red jeans';

/*
Prediction Result:
('Dup Supplier', '555-0199')
*/