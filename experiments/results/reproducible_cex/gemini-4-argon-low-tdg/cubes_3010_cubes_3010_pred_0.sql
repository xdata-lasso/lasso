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
-- Tests boundary values for booked_amount (exact match 102.76, just below, just above, negative, zero, NULL) and column confusion with daily_hire_cost and product_name.
INSERT INTO "Discount_Coupons" ("coupon_id", "date_issued", "coupon_amount") VALUES (1, '2023-01-01', 10.0);
INSERT INTO "Customers" ("customer_id", "coupon_id", "good_or_bad_customer", "first_name", "last_name", "gender_mf", "date_became_customer", "date_last_hire") VALUES (1, 1, 'good', 'John', 'Doe', 'M', '2023-01-01', '2023-01-02');
INSERT INTO "Bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (1, 1, 'CONF', 'N', '2023-01-01', '2023-01-05', '1', 50.0, 0.0, 0.0, 0.0);
INSERT INTO "Products_for_Hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (1, 'T1', 500.0, 'Name_Exact', 'Desc_Exact_102.76');
INSERT INTO "Products_for_Hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (2, 'T2', 500.0, 'Name_Below', 'Desc_Below_102.75');
INSERT INTO "Products_for_Hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (3, 'T3', 10.0, 'Name_Above', 'Desc_Above_102.77');
INSERT INTO "Products_for_Hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (4, 'T4', 10.0, 'Name_NullAmt', 'Desc_Null_BookedAmount');
INSERT INTO "Products_for_Hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (5, 'T5', 200.0, 'Name_Zero', 'Desc_Zero_0.00');
INSERT INTO "Products_for_Hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (6, 'T6', 300.0, 'Name_Neg', 'Desc_Negative_-10.50');
INSERT INTO "Products_Booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (1, 1, 'Y', 'N', 200, 102.76);
INSERT INTO "Products_Booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (1, 2, 'N', 'Y', 200, 102.759);
INSERT INTO "Products_Booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (1, 3, 'Y', 'N', 1, 102.761);
INSERT INTO "Products_Booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (1, 4, 'Y', 'N', 1, NULL);
INSERT INTO "Products_Booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (1, 5, 'Y', 'N', 500, 0.0);
INSERT INTO "Products_Booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (1, 6, 'N', 'N', 500, -10.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_description FROM (SELECT LHS.product_id AS product_id, LHS.product_type_code AS product_type_code, LHS.daily_hire_cost AS daily_hire_cost, LHS.product_name AS product_name, LHS.product_description AS product_description, RHS.booking_id AS booking_id, RHS.returned_yn AS returned_yn, RHS.returned_late_yn AS returned_late_yn, RHS.booked_count AS booked_count, RHS.booked_amount AS booked_amount FROM products_for_hire AS LHS INNER JOIN products_booked AS RHS ON (LHS.product_id = RHS.product_id)) WHERE (booked_amount <= 102.76) ORDER BY product_description;

/*
Gold Result:
('Desc_Below_102.75',)
('Desc_Exact_102.76',)
('Desc_Negative_-10.50',)
('Desc_Zero_0.00',)
*/

-- Prediction Query
SELECT T2.product_description FROM products_booked AS T1 JOIN products_for_hire AS T2 ON T1.product_id = T2.product_id WHERE T1.booked_amount = 102.76;

/*
Prediction Result:
('Desc_Exact_102.76',)
*/