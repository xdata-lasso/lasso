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
INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (1219, 'Taylor Durham');
INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (1220, 'Alexis Patel');
INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (1221, 'Alan Bowen');
INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (1231, 'Brandon George');
INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (1232, 'James Carter');
INSERT INTO "department_store_chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (1233, 'Bradley Santana');
INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (1222, 'north', 'Melissa Jordan');
INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (1223, 'few', 'Melissa Jordan');
INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (1224, 'adult', 'Melissa Jordan');
INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (1234, 'west', 'Melissa Jackson');
INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (1235, 'eight', 'Melissa Jackson');
INSERT INTO "staff" ("staff_id", "staff_gender", "staff_name") VALUES (1236, 'owner', 'Melissa Jackson');
INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (1225, 1219, 'Cassie Hull', '9334 Desiree Walks Apt. 166
Tranton, SC 01739', '842-493-9685', 'bartonkenneth@example.org');
INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (1226, 1219, 'Daisy Harvey', '6591 Jerry Ways
Nelsonland, TX 37250', '001-818-750-1631x599', 'millereric@example.net');
INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (1227, 1219, 'Hector Norton', 'PSC 9025, Box 0392
APO AP 52706', '4478735866', 'jodistewart@example.org');
INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (1237, 1231, 'Derrick Thomas', '937 Derek Avenue Suite 596
Scottchester, GU 85833', '837.841.6724x342', 'smithjonathan@example.net');
INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (1238, 1231, 'Donald Evans', 'Unit 2459 Box 3752
DPO AA 42331', '279-779-6886', 'seanmyers@example.net');
INSERT INTO "department_stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (1239, 1231, 'Heather Raymond', '356 Velasquez Lock Suite 193
Lake Katrina, AK 95818', '001-789-811-3529x096', 'michaeljohnson@example.org');
INSERT INTO "departments" ("department_id", "dept_store_id", "department_name") VALUES (1228, 1225, 'Tommy Wallace');
INSERT INTO "departments" ("department_id", "dept_store_id", "department_name") VALUES (1229, 1225, 'Ashley Miller');
INSERT INTO "departments" ("department_id", "dept_store_id", "department_name") VALUES (1230, 1225, 'Justin Hunt');
INSERT INTO "departments" ("department_id", "dept_store_id", "department_name") VALUES (1240, 1237, 'Thomas Miller');
INSERT INTO "departments" ("department_id", "dept_store_id", "department_name") VALUES (1241, 1237, 'Monica Bailey');
INSERT INTO "departments" ("department_id", "dept_store_id", "department_name") VALUES (1242, 1237, 'Richard Boyd');
INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (1222, 1228, '1988-07-14', 'Civil engineer, contracting', '1991-10-17');
INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (1222, 1229, '1988-07-15', 'Civil engineer, contracting', '1991-10-18');
INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (1222, 1230, '1988-07-16', 'Civil engineer, contracting', '1991-10-19');
INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (1234, 1240, '1994-02-20', 'Civil engineer, contracting', '1997-05-23');
INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (1234, 1241, '1994-02-21', 'Civil engineer, contracting', '1997-05-24');
INSERT INTO "staff_department_assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (1234, 1242, '1994-02-22', 'Civil engineer, contracting', '1997-05-25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT staff_name FROM (SELECT staff_id, staff_name, COUNT(*) AS n FROM (SELECT LHS.staff_id AS staff_id, LHS.staff_gender AS staff_gender, LHS.staff_name AS staff_name, RHS.department_id AS department_id, RHS.date_assigned_from AS date_assigned_from, RHS.job_title_code AS job_title_code, RHS.date_assigned_to AS date_assigned_to FROM staff AS LHS INNER JOIN staff_department_assignments AS RHS ON (LHS.staff_id = RHS.staff_id)) GROUP BY staff_id, staff_name) WHERE (n > 1) ORDER BY staff_name;

/*
Gold Result:
('Melissa Jackson',)
('Melissa Jordan',)
*/

-- Prediction Query
SELECT T1.staff_name FROM staff AS T1 JOIN staff_department_assignments AS T2 ON T1.staff_id = T2.staff_id GROUP BY T2.staff_id HAVING COUNT(*) > 1;

/*
Prediction Result:
('Melissa Jordan',)
('Melissa Jackson',)
*/