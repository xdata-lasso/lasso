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
-- Tests asymmetric cross-matching where LHS.dept_store_chain_id = RHS.dept_store_id AND LHS.n = RHS.dept_store_chain_id, with n != dept_store_chain_id.
-- Also tests ordering, duplicate outputs, and non-matching chains.
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (1, 'Chain One');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (2, 'Chain Two');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (3, 'Chain Three');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (10, 'Chain Ten');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (20, 'Chain Twenty');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (30, 'Chain Thirty');
-- Chain 10 has 2 stores -> LHS: (dept_store_chain_id=10, n=2)
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (101, 10, 'Store 101', 'Addr 101', '111-101', 's101@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (102, 10, 'Store 102', 'Addr 102', '111-102', 's102@store.com');
-- Chain 20 has 1 store -> LHS: (dept_store_chain_id=20, n=1)
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (201, 20, 'Store 201', 'Addr 201', '111-201', 's201@store.com');
-- Chain 30 has 2 stores -> LHS: (dept_store_chain_id=30, n=2)
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (301, 30, 'Store 301', 'Addr 301', '111-301', 's301@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (302, 30, 'Store 302', 'Addr 302', '111-302', 's302@store.com');
-- RHS matching rows:
-- Matches LHS(10, 2): dept_store_id = 10, dept_store_chain_id = 2
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (10, 2, 'Target Store 10', 'Addr 10', '999-010', 't10@store.com');
-- Matches LHS(20, 1): dept_store_id = 20, dept_store_chain_id = 1
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (20, 1, 'Target Store 20', 'Addr 20', '999-020', 't20@store.com');
-- Matches LHS(30, 2): dept_store_id = 30, dept_store_chain_id = 2 (produces duplicate n=2 in final output)
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (30, 2, 'Target Store 30', 'Addr 30', '999-030', 't30@store.com');
-- Decoy rows to kill partial join condition mutants (e.g. only checking dept_store_chain_id = dept_store_id, or OR instead of AND)
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (2, 3, 'Decoy Store 2', 'Addr 2', '000-002', 'd2@store.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS dept_store_chain_id FROM (SELECT dept_store_chain_id, n, store_name, store_address, store_phone, store_email, dept_store_chain_id AS dept_store_id FROM (SELECT LHS.dept_store_chain_id AS dept_store_chain_id, LHS.n AS n, RHS.store_name AS store_name, RHS.store_address AS store_address, RHS.store_phone AS store_phone, RHS.store_email AS store_email FROM (SELECT dept_store_chain_id, COUNT(*) AS n FROM department_stores GROUP BY dept_store_chain_id) AS LHS INNER JOIN department_stores AS RHS ON (LHS.dept_store_chain_id = RHS.dept_store_id AND LHS.n = RHS.dept_store_chain_id))) ORDER BY dept_store_chain_id;

/*
Gold Result:
(1,)
(2,)
(2,)
*/

-- Prediction Query
SELECT dept_store_chain_id FROM department_stores GROUP BY dept_store_chain_id ORDER BY COUNT(*) DESC, dept_store_chain_id NULLS LAST LIMIT 2;

/*
Prediction Result:
(2,)
(10,)
*/