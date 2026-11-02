-- Schema DDL
CREATE TABLE "Discount_Coupons" ("coupon_id" INTEGER PRIMARY KEY, "date_issued" DATETIME, "coupon_amount" REAL(19, 4));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "coupon_id" INTEGER, "good_or_bad_customer" TEXT(4), "first_name" TEXT(80), "last_name" TEXT(80), "gender_mf" TEXT(1), "date_became_customer" DATETIME, "date_last_hire" DATETIME, FOREIGN KEY ("coupon_id") REFERENCES "Discount_Coupons" ("coupon_id"));

CREATE TABLE "Bookings" ("booking_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "booking_status_code" TEXT(10), "returned_damaged_yn" TEXT(40), "booking_start_date" DATETIME, "booking_end_date" DATETIME, "count_hired" TEXT(40), "amount_payable" REAL(19, 4), "amount_of_discount" REAL(19, 4), "amount_outstanding" REAL(19, 4), "amount_of_refund" REAL(19, 4), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Products_for_Hire" ("product_id" INTEGER PRIMARY KEY, "product_type_code" TEXT(15), "daily_hire_cost" REAL(19, 4), "product_name" TEXT(80), "product_description" TEXT(255));

CREATE TABLE "Payments" ("payment_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "booking_id" INTEGER, "payment_type_code" TEXT(15), "amount_paid_in_full_yn" TEXT(1), "payment_date" DATETIME, "amount_due" REAL(19, 4), "amount_paid" REAL(19, 4), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("booking_id") REFERENCES "Bookings" ("booking_id"));

CREATE TABLE "Products_Booked" ("booking_id" INTEGER, "product_id" INTEGER, "returned_yn" TEXT(1), "returned_late_yn" TEXT(1), "booked_count" INTEGER, "booked_amount" REAL, PRIMARY KEY ("booking_id", "product_id"), FOREIGN KEY ("product_id") REFERENCES "Products_for_Hire" ("product_id"), FOREIGN KEY ("booking_id") REFERENCES "Bookings" ("booking_id"));

CREATE TABLE "View_Product_Availability" ("status_date" DATETIME PRIMARY KEY, "product_id" INTEGER, "booking_id" INTEGER, "available_yn" TEXT(1), FOREIGN KEY ("product_id") REFERENCES "Products_for_Hire" ("product_id"), FOREIGN KEY ("booking_id") REFERENCES "Bookings" ("booking_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Missing DISTINCT (duplicate 'CREDIT' and 'CASH' values).
-- 2. Missing or reversed ORDER BY (inserted in non-alphabetical order: 'WIRE', 'CREDIT', 'CASH', 'DEBIT').
-- 3. Unnecessary INNER JOINs with Customers or Bookings (payment_id 3 has NULL customer_id, payment_id 4 has NULL booking_id).
-- 4. Spurious WHERE clauses filtering on amount_paid_in_full_yn ('Y', 'N') or comparing amount_due vs amount_paid.
-- 5. Wrong column/table selection (booking_status_code and product_type_code have distinct values from payment_type_code).
INSERT INTO "Discount_Coupons" ("coupon_id", "date_issued", "coupon_amount") VALUES (1, '2023-01-01 00:00:00', 10.0);
INSERT INTO "Customers" ("customer_id", "coupon_id", "good_or_bad_customer", "first_name", "last_name", "gender_mf", "date_became_customer", "date_last_hire") VALUES (1, 1, 'good', 'Alice', 'Smith', 'F', '2022-01-01 00:00:00', '2023-05-01 00:00:00');
INSERT INTO "Customers" ("customer_id", "coupon_id", "good_or_bad_customer", "first_name", "last_name", "gender_mf", "date_became_customer", "date_last_hire") VALUES (2, NULL, 'bad', 'Bob', 'Jones', 'M', '2022-02-01 00:00:00', '2023-06-01 00:00:00');
INSERT INTO "Bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (1, 1, 'CONFIRMED', 'N', '2023-05-01 00:00:00', '2023-05-05 00:00:00', '2', 100.0, 10.0, 0.0, 0.0);
INSERT INTO "Bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (2, 2, 'CANCELLED', 'Y', '2023-06-01 00:00:00', '2023-06-03 00:00:00', '1', 50.0, 0.0, 50.0, 0.0);
INSERT INTO "Products_for_Hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (1, 'TOOL', 25.0, 'Drill', 'Power drill');
INSERT INTO "Products_for_Hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (2, 'VEHICLE', 100.0, 'Van', 'Cargo van');
INSERT INTO "Payments" ("payment_id", "customer_id", "booking_id", "payment_type_code", "amount_paid_in_full_yn", "payment_date", "amount_due", "amount_paid") VALUES (1, 1, 1, 'WIRE', 'Y', '2023-05-01 10:00:00', 100.0, 100.0);
INSERT INTO "Payments" ("payment_id", "customer_id", "booking_id", "payment_type_code", "amount_paid_in_full_yn", "payment_date", "amount_due", "amount_paid") VALUES (2, 1, 1, 'CREDIT', 'N', '2023-05-02 10:00:00', 100.0, 50.0);
INSERT INTO "Payments" ("payment_id", "customer_id", "booking_id", "payment_type_code", "amount_paid_in_full_yn", "payment_date", "amount_due", "amount_paid") VALUES (3, NULL, 2, 'CASH', 'Y', '2023-06-01 10:00:00', 50.0, 50.0);
INSERT INTO "Payments" ("payment_id", "customer_id", "booking_id", "payment_type_code", "amount_paid_in_full_yn", "payment_date", "amount_due", "amount_paid") VALUES (4, 2, NULL, 'DEBIT', 'N', '2023-06-02 10:00:00', 50.0, 0.0);
INSERT INTO "Payments" ("payment_id", "customer_id", "booking_id", "payment_type_code", "amount_paid_in_full_yn", "payment_date", "amount_due", "amount_paid") VALUES (5, 2, 2, 'CREDIT', 'Y', '2023-06-03 10:00:00', 50.0, 50.0);
INSERT INTO "Payments" ("payment_id", "customer_id", "booking_id", "payment_type_code", "amount_paid_in_full_yn", "payment_date", "amount_due", "amount_paid") VALUES (6, 1, 2, 'CASH', 'N', '2023-06-04 10:00:00', 50.0, 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT payment_type_code FROM payments ORDER BY payment_type_code;

/*
Gold Result:
('CASH',)
('CREDIT',)
('DEBIT',)
('WIRE',)
*/

-- Prediction Query
SELECT DISTINCT payment_type_code FROM payments;

/*
Prediction Result:
('WIRE',)
('CREDIT',)
('CASH',)
('DEBIT',)
*/