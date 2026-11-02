-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic INNER JOIN, GROUP BY on (complaint_outcome_code, product_id), and excludes products without complaints.
INSERT INTO Staff (staff_id, first_name) VALUES (1, 'Alice');
INSERT INTO Customers (customer_id, customer_type_code) VALUES (1, 'IND');
INSERT INTO Products (product_id, product_name, product_price) VALUES (10, 'Alpha', 10.0);
INSERT INTO Products (product_id, product_name, product_price) VALUES (20, 'Beta', 20.0);
INSERT INTO Products (product_id, product_name, product_price) VALUES (30, 'Gamma', 30.0);
INSERT INTO Complaints (complaint_id, customer_id, product_id, staff_id, complaint_outcome_code) VALUES (101, 1, 10, 1, 'RESOLVED');
INSERT INTO Complaints (complaint_id, customer_id, product_id, staff_id, complaint_outcome_code) VALUES (102, 1, 10, 1, 'RESOLVED');
INSERT INTO Complaints (complaint_id, customer_id, product_id, staff_id, complaint_outcome_code) VALUES (103, 1, 10, 1, 'PENDING');
INSERT INTO Complaints (complaint_id, customer_id, product_id, staff_id, complaint_outcome_code) VALUES (104, 1, 20, 1, 'RESOLVED');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, n AS count___ FROM (SELECT LHS.product_id AS product_id, LHS.parent_product_id AS parent_product_id, LHS.product_category_code AS product_category_code, LHS.date_product_first_available AS date_product_first_available, LHS.date_product_discontinued AS date_product_discontinued, LHS.product_name AS product_name, LHS.product_description AS product_description, LHS.product_price AS product_price, RHS.complaint_outcome_code AS complaint_outcome_code, RHS.n AS n FROM products AS LHS INNER JOIN (SELECT complaint_outcome_code, product_id, COUNT(*) AS n FROM complaints GROUP BY complaint_outcome_code, product_id) AS RHS ON (LHS.product_id = RHS.product_id)) ORDER BY product_name, count___ NULLS LAST;

/*
Gold Result:
('Alpha', 1)
('Alpha', 2)
('Beta', 1)
*/

-- Prediction Query
SELECT t1.product_name, COUNT(*) FROM products AS t1 JOIN complaints AS t2 ON t1.product_id = t2.product_id GROUP BY t1.product_name;

/*
Prediction Result:
('Alpha', 3)
('Beta', 1)
*/