-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Staff" ("staff_id", "gender", "first_name", "last_name", "email_address", "phone_number") VALUES (1, 'M', 'John', 'Doe', 'john@example.com', '111-2222');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1, 'REG', '123 Main St', NULL, 'Metropolis', 'NY', 'cust1@example.com', '333-4444');
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1, NULL, 'ELEC', '2020-01-01 00:00:00', NULL, 'Widget', 'A standard widget', 19.99);
-- Status 'Z_STATUS' with Outcome 'A_OUT': count = 3 (tests boundary n = 3 and ordering vs outcome/count)
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 1, 1, 1, 'A_OUT', 'Z_STATUS', 'T1', '2021-01-01', '2021-01-02');
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 1, 1, 2, 'A_OUT', 'Z_STATUS', 'T1', '2021-01-01', '2021-01-02');
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 1, 1, 3, 'A_OUT', 'Z_STATUS', 'T1', '2021-01-01', '2021-01-02');
-- Status 'A_STATUS' with Outcome 'Z_OUT': count = 4 (tests n > 3 and ASC ordering on status vs insertion/outcome/count)
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 1, 1, 4, 'Z_OUT', 'A_STATUS', 'T1', '2021-01-01', '2021-01-02');
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 1, 1, 5, 'Z_OUT', 'A_STATUS', 'T2', '2021-01-01', '2021-01-02');
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 1, 1, 6, 'Z_OUT', 'A_STATUS', 'T3', '2021-01-01', '2021-01-02');
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 1, 1, 7, 'Z_OUT', 'A_STATUS', 'T4', '2021-01-01', '2021-01-02');
-- Status 'M_STATUS' split across two outcomes: count = 2 each, total for status = 4 (kills mutants missing complaint_outcome_code in GROUP BY)
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 1, 1, 8, 'OUT_1', 'M_STATUS', 'T1', '2021-01-01', '2021-01-02');
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 1, 1, 9, 'OUT_1', 'M_STATUS', 'T1', '2021-01-01', '2021-01-02');
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 1, 1, 10, 'OUT_2', 'M_STATUS', 'T1', '2021-01-01', '2021-01-02');
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 1, 1, 11, 'OUT_2', 'M_STATUS', 'T1', '2021-01-01', '2021-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT complaint_status_code FROM (SELECT complaint_outcome_code, complaint_status_code, COUNT(*) AS n FROM complaints GROUP BY complaint_outcome_code, complaint_status_code) WHERE (n >= 3) ORDER BY complaint_status_code;

/*
Gold Result:
('A_STATUS',)
('Z_STATUS',)
*/

-- Prediction Query
SELECT complaint_status_code FROM complaints GROUP BY complaint_status_code HAVING COUNT(*) > 3;

/*
Prediction Result:
('A_STATUS',)
('M_STATUS',)
*/