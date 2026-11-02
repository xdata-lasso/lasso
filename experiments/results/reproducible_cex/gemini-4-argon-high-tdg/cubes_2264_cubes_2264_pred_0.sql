-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Staff (staff_id, gender, first_name, last_name, email_address, phone_number) VALUES (1, 'F', 'Alice', 'Smith', 'alice@example.com', '555-0101');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (1, 'REG', '10 Main St', NULL, 'Austin', 'TX', 'c1@example.com', '555-0201');
INSERT INTO Products (product_id, parent_product_id, product_category_code, date_product_first_available, date_product_discontinued, product_name, product_description, product_price) VALUES (1, NULL, 'ELEC', '2022-01-01 00:00:00', NULL, 'Alpha', 'First product', 100.00);
INSERT INTO Products (product_id, parent_product_id, product_category_code, date_product_first_available, date_product_discontinued, product_name, product_description, product_price) VALUES (2, NULL, 'ELEC', '2022-01-01 00:00:00', NULL, 'Beta', 'Second product', 200.00);
INSERT INTO Products (product_id, parent_product_id, product_category_code, date_product_first_available, date_product_discontinued, product_name, product_description, product_price) VALUES (3, NULL, 'ELEC', '2022-01-01 00:00:00', NULL, 'Gamma', 'Product without complaints', 300.00);
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 101, 'O1', 'CLOSED', 'DEFECT', '2023-01-01 10:00:00', '2023-01-02 10:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 102, 'O1', 'CLOSED', 'DEFECT', '2023-01-03 10:00:00', '2023-01-04 10:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 103, 'O1', 'CLOSED', 'DEFECT', '2023-01-05 10:00:00', '2023-01-06 10:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 104, 'O2', 'OPEN', 'DELAY', '2023-01-07 10:00:00', NULL);
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 105, 'O3', 'CLOSED', 'BILLING', '2023-01-08 10:00:00', '2023-01-09 10:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 106, 'O3', 'CLOSED', 'BILLING', '2023-01-10 10:00:00', '2023-01-11 10:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 2, 1, 107, 'O1', 'OPEN', 'DEFECT', '2023-01-12 10:00:00', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, n AS count___ FROM (SELECT LHS.product_id AS product_id, LHS.parent_product_id AS parent_product_id, LHS.product_category_code AS product_category_code, LHS.date_product_first_available AS date_product_first_available, LHS.date_product_discontinued AS date_product_discontinued, LHS.product_name AS product_name, LHS.product_description AS product_description, LHS.product_price AS product_price, RHS.complaint_outcome_code AS complaint_outcome_code, RHS.n AS n FROM products AS LHS INNER JOIN (SELECT complaint_outcome_code, product_id, COUNT(*) AS n FROM complaints GROUP BY complaint_outcome_code, product_id) AS RHS ON (LHS.product_id = RHS.product_id)) ORDER BY product_name, count___ NULLS LAST;

/*
Gold Result:
('Alpha', 1)
('Alpha', 2)
('Alpha', 3)
('Beta', 1)
*/

-- Prediction Query
SELECT t1.product_name, COUNT(*) FROM products AS t1 JOIN complaints AS t2 ON t1.product_id = t2.product_id GROUP BY t1.product_name;

/*
Prediction Result:
('Alpha', 6)
('Beta', 1)
*/